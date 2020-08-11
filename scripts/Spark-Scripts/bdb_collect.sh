set_remote_spark_home()
{
    # HADOOP_HOME=/disk2/user/hadoops/hadoop-$1
    # echo "HADOOP_BASE=$HADOOP_HOME" > ~/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/hadoophome.sh
    SPARK_HOME=/home/shaanzie/spark-$1
    export SPARK_HOME=$SPARK_HOME
    export PATH=$PATH:$SPARK_HOME/bin
}

cleanup_bdb () 
{
    $HADOOP_HOME/bin/hdfs dfs -rmr /$1
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
    input=$6
    output=$7
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
           echo sar_process
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
    perfcommand='perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C  -x "," -o $file -I $delay'
    sar -r ALL -R -B -W -S -u ALL -H -h -o $sar_file $sar_delay > /dev/null 2>&1 & 
    sar_process=$!
    echo $sar_process

    sync #flush all buffers. 
    sleep 1
    #command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout $perfcommand bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command  &"
    # command="bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command  &"
    # command="bash ~/BigDataBench_V5.0_BigData_ComponentBenchmark-master/Spark/$remote_command &"
    echo $input
    command="spark-submit --class cn.ac.ict.bigdatabench.$bench ~/BigDataBench-Spark/target/scala-2.10/bigdatabench-spark_2.10-1.3.0.jar $input $output"
    echo "Executing: $command"
    eval $command

    timepid=$!
    bashpid=`ps -elf | grep "$remote_command" | grep -v "/usr/bin/time" |  grep -v "grep" |   tr -s " " | cut -d " " -f 4`
    sleep 3
    javapid=`ps -elf | grep "$bashpid" | grep -v "grep" | tail -n 1 | tr -s " " | cut -d ' ' -f 4`
    namenode=`jps | grep -i -w  "NameNode" | cut -d " " -f 1`
    datanode=`jps | grep -i -w  "DataNode" | cut -d " " -f 1`
    nodeManager= `jps | grep -i -w  "NodeManager" | cut -d " " -f 1`
    resourcemanager=`jps | grep -i -w  "ResourceManager" | cut -d " " -f 1`
    secondarynamenode=`jps | grep -i -w  "SecondaryNameNode" | cut -d " " -f 1`
    master=`jps | grep -i -w  "Master" | cut -d " " -f 1`
    worker=`jps | grep -i -w  "Worker" | cut -d " " -f 1`
     
    echo -e "Bash: $bashpid Java: $javapid Hadoop: $namenode,$datanode,$nodeManager,$resourcemanager,$secondarynamenode,$master,$worker"
    pidstat -h -d -r -s -u -T ALL -p $javapid,$namenode,$datanode,$nodeManager,$resourcemanager,$secondarynamenode,$master,$worker $sar_delay > $pidstat_file &
    pidstat=$!
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

spark="2.4.6"
# spark="3.0.0"

hadoop="2.10.0"
#hadoop="3.2.1"

set="set1"

case $profile in 
    "tiny")
        bayes=1
        cf=1
        km=1
        lda=1
        pr=5
    ;;
    "small")
        bayes=10
        cf=10
        km=10
        lda=10
        pr=10
    ;;
    "large")
        bayes=30
        cf=30
        km=30
        lda=30
        pr=30

    ;;
    *)
    #     cc=8
    #     fft_dim=1024
    #     fft_sparsity=0.5
	# grep=1
    #     matmult_dim=100
    #     matmult_sparsity=0.5
    #     md5=1
    #     randsample=1
    ;;
esac 


set_remote_spark_home  $spark 

# Preparing data

$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-inputData/wc/wc-input.txt /wc
$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-inputData/sort/sort-input.txt /sort
$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-inputData/grep/grep-input.txt /grep
$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-inputData/cc/cc-input /cc
$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-inputData/pr/pr-input.txt /pr



vmpid=0
# cleanup_bdb_cc
# run_remote_workload_bdb $vmpid "WordCount" "prep" "Bayes/genData-bayes.sh $bayes" $time_log $set
run_remote_workload_bdb $vmpid "WordCount" "run" "WordCount" $time_log $set /wc /wc-out
cleanup_bdb "wc-out"

# run_remote_workload_bdb $vmpid "cf" "prep" "CF/genData-cf.sh $cf" $time_log $set
# run_remote_workload_bdb $vmpid "cf" "run" "CF/runSpark-cf.sh $cf" $time_log $set
# cleanup_bdb "cf"

# run_remote_workload_bdb $vmpid "km" "prep" "Kmeans/genData-kmeans.sh $km" $time_log $set
# run_remote_workload_bdb $vmpid "km" "run" "Kmeans/runSpark-kmeans.sh $km" $time_log $set
# cleanup_bdb "km"

# run_remote_workload_bdb $vmpid "lda" "prep" "LDA/genData-lda.sh $lda" $time_log $set
# run_remote_workload_bdb $vmpid "lda" "run" "LDA/runSpark-lda.sh $lda" $time_log $set
# cleanup_bdb "lda"

# run_remote_workload_bdb $vmpid "pr" "prep" "PageRank/genData-pagerank.sh $pr" $time_log $set
# run_remote_workload_bdb $vmpid "pr" "run" "PageRank/runSpark-PageRank.sh $pr" $time_log $set
# cleanup_bdb "pr"

# expunge

# mkdir -p ~/SparkData/bdb/$hadoop/$profile/
# mv $time_log ~/SparkData/bdb/$hadoop/$profile/
# mv *.csv ~/SparkData/bdb/$hadoop/$profile/
# mv *.pidstat ~/SparkData/bdb/$hadoop/$profile/
# rm $sar_file