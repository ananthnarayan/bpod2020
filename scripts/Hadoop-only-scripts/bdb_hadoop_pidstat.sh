set_remote_hadoop_home()
{
    HADOOP_HOME=/disk2/user/hadoops/hadoop-$1
    echo "HADOOP_BASE=$HADOOP_HOME" > ~/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/hadoophome.sh
}

cleanup_bdb () 
{
    $HADOOP_HOME/bin/hdfs dfs -rm -r /hadoop/$1
}
cleanup_bdb_cc ()
{
    $HADOOP_HOME/bin/hdfs dfs -rm -r /user/user/*
    $HADOOP_HOME/bin/hdfs dfs -rm -r /user/ananth/*
}
check_bdb_conf()
{
	echo ""
}

expunge () {
    $HADOOP_HOME/bin/hdfs dfs -expunge 
}


run_remote_workload_bdb() {
    vmpid=$1
    bench=$2
    action=$3
    #1 second delay
    delay=1000
    
    sar_delay=1
    
    file=${bench}_${action}_$6.perf
    
    sar_file=sar_out
    rm $sar_file
     sar_csv=sar_${bench}_${action}.csv
    
    pidstat_file=${bench}_${action}.pidstat
    
    remote_command=$4
    time_log=$5
    
    #Clean up any old instances
    killall sar 
    
    echo "===== $bench : $action ======"
    case $6 in
    "set1")
    	   perfcommand='perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C  -x "," -o $file -I $delay'
           sar -r ALL -R -B -W -S -u ALL -H -h -o $sar_file $sar_delay > /dev/null 2>&1 & 
           sar_process=$!
	       ;;
    "set2")
            perfcommand='perf stat -e r3f24 -e ref24 -e r0151 -e r0480 -e context-switches -e page-faults  -x "," -o $file -I $delay'
           sar -r ALL -R -B -W -S -u ALL -H -h -o $sar_file $sar_delay > /dev/null 2>&1 & 
            sar_process=$!
            ;;
    "set3")
            perfcommand='perf stat  -e r81d0 -e r82d0  -x "," -o $file -I $delay '
           sar -r ALL -R -B -W -S -u ALL -H -h -o $sar_file $sar_delay > /dev/null 2>&1 & 
            sar_process=$!
            ;;
    esac
    sync #flush all buffers. 
    sleep 1
    #command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout $perfcommand bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command  &"
    command="bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command  &"
    echo "Executing: $command"
    eval $command
#26546 SecondaryNameNode
#26116 NameNode
#26279 DataNode
#27052 NodeManager
#27230 Jps
#26847 ResourceManager

    timepid=$!
    bashpid=`ps -elf | grep "$remote_command" | grep -v "/usr/bin/time" |  grep -v "grep" |   tr -s " " | cut -d " " -f 4`
    sleep 3
    javapid=`ps -elf | grep "$bashpid" | grep -v "grep" | tail -n 1 | tr -s " " | cut -d ' ' -f 4`
    namenode=`jps | grep -i -w  "NameNode" | cut -d " " -f 1`
    datanode=`jps | grep -i -w  "DataNode" | cut -d " " -f 1`
    nodemanager= `jps | grep -i -w  "NodeManager" | cut -d " " -f 1`
    resourcemanager=`jps | grep -i -w  "ResourceManager" | cut -d " " -f 1`
    secondarynamenode=`jps | grep -i -w  "SecondaryNameNode" | cut -d " " -f 1`
     
    echo -e "Bash: $bashpid Java: $javapid Hadoop: $namenode,$datanode,$nodemanager,$resourcemanager,$secondarynamenode"
    pidstat -h -d -r -s -u -T ALL -p $javapid,$namenode,$datanode,$nodemanager,$resourcemanager,$secondarynamenode $sar_delay > $pidstat_file &  
    echo "killing sar"
    kill -s SIGINT $sar_process
    #Pidstat would have terminated already. this is just for cleanup from our side. 
    echo "killing pidstat"
    kill -s SIGINT $pidstat 

    case $6 in
    	"set1")
            sadf -dh $sar_file -- -r ALL -R -B -W -S -u ALL -H -h > $sar_csv 
	    ;;
	"set2")
            sadf -dh $sar_file -- -r ALL -R -B -W -S -u ALL -H -h > $sar_csv 
		;;
	"set3")
            sadf -dh $sar_file -- -r ALL -R -B -W -S -u ALL -H -h > $sar_csv 
		;;
    esac 
    
    bench=$bench
    action=$action
    
    echo "Start sleep after $action"
    sleep 10

}

### == end function definitions == ###
check_bdb_conf

profile="tiny" 

hadoop="2.10.0"
#hadoop="3.2.1"
set="set1"

case $profile in 
    "tiny")
        cc=8
        fft_dim=1024
        fft_sparsity=0.5
	grep=1
        matmult_dim=100
        matmult_sparsity=0.5
        md5=1
        randsample=1
    ;;
    "small")
        cc=11
        fft_dim=2048
        fft_sparsity=0.5
	grep=5
        matmult_dim=1000
        matmult_sparsity=0.5
        md5=5
        randsample=5
    ;;
    "large")
        cc=15
        fft_dim=4096
        fft_sparsity=0.5
	grep=10
        matmult_dim=10000
        matmult_sparsity=0.5
        md5=10
        randsample=10
    ;;
    *)
        cc=8
        fft_dim=1024
        fft_sparsity=0.5
	grep=1
        matmult_dim=100
        matmult_sparsity=0.5
        md5=1
        randsample=1
    ;;
esac 


set_remote_hadoop_home  $hadoop 


vmpid=0
cleanup_bdb_cc
run_remote_workload_bdb $vmpid "cc" "prep" "CC/genData-cc.sh $cc" $time_log $set
run_remote_workload_bdb $vmpid "cc" "run" "CC/run-cc.sh $cc" $time_log $set
cleanup_bdb "cc"

run_remote_workload_bdb $vmpid "fft0_5" "prep" "FFT/genData-fft.sh $fft_dim $fft_dim $fft_sparsity" $time_log $set
run_remote_workload_bdb $vmpid "fft0_5" "run" "FFT/run-fft.sh $fft_dim $fft_dim $fft_sparsity" $time_log $set
cleanup_bdb "fft"

run_remote_workload_bdb $vmpid "grep" "prep" "Grep/genData-grep.sh $grep" $time_log $set
run_remote_workload_bdb $vmpid "grep" "run" "Grep/run-grep.sh $grep" $time_log $set
cleanup_bdb "grep"

run_remote_workload_bdb $vmpid "matmult0_5" "prep" "MatrixMult/genData-matMult.sh $matmult_sparsity $matmult_dim $matmult_dim $matmult_dim" $time_log $set
run_remote_workload_bdb $vmpid "matmult0_5" "run" "MatrixMult/run-matMult.sh $matmult_sparsity $matmult_dim $matmult_dim $matmult_dim" $time_log $set
cleanup_bdb "matMult"

run_remote_workload_bdb $vmpid "md5" "prep" "MD5/genData-md5.sh $md5" $time_log $set
run_remote_workload_bdb $vmpid "md5" "run" "MD5/run-md5.sh $md5" $time_log $set
cleanup_bdb "md5"
 
run_remote_workload_bdb $vmpid "randsample" "prep" "randSample/genData-randSample.sh $randsample" $time_log $set
run_remote_workload_bdb $vmpid "randsample" "run" "randSample/run-randSample.sh $randsample 0.5" $time_log $set
cleanup_bdb "randsample" 

run_remote_workload_bdb $vmpid "sort" "prep" "Sort/genData-sort.sh $grep" $time_log $set
run_remote_workload_bdb $vmpid "sort" "run" "Sort/run-terasort.sh $grep" $time_log $set
cleanup_bdb "terasort"

run_remote_workload_bdb $vmpid "wc" "prep" "wordcount/genData-wc.sh $grep" $time_log $set
run_remote_workload_bdb $vmpid "wc" "run" "wordcount/run-wordcount.sh $grep" $time_log $set
cleanup_bdb "wd"

expunge

mkdir -p ~/ananth/hadoopfinal-data/bdb/$hadoop/$profile/
mv $time_log ~/ananth/hadoopfinal-data/bdb/$hadoop/$profile/
mv *.csv ~/ananth/hadoopfinal-data/bdb/$hadoop/$profile/
mv *.pidstat ~/ananth/hadoopfinal-data/bdb/$hadoop/$profile/
rm $sar_file
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/BigDataGeneratorSuite/Text_datagen/gsl-1.15/.libs/:disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/BigDataGeneratorSuite/Text_datagen/gsl-1.15/cblas/.libs/


# From BDB Paper: 
# Large is set to use all RAM. The other two are scaled down from that value.
# for matrix: 100, 1k, 10k 
# for FFT, 16kx16k, 32kx32k, 64kx64k
# for sparsity dependency for fft, 2 16384×16384 matrices, with 0.1 and 0.9 sparsity.
##
