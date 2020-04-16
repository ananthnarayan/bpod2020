set_remote_hadoop_home()
{
    HADOOP_HOME=/disk2/user/hadoops/hadoop-$1
}

cleanup_bdb () 
{
    $HADOOP_HOME/bin/hdfs dfs -rm -r /hadoop/$1
}
cleanup_bdb_cc ()
{
    $HADOOP_HOME/bin/hdfs dfs -rm -r /user/user/*
}
check_bdb_conf()
{
	echo ""
}

set_path() {
    export PATH=$PATH:/home/user/pmu-tools
}
expunge () {
    $HADOOP_HOME/bin/hdfs dfs -expunge 
}


run_workload_toplev_bdb() {
    vmpid=$1
    bench=$2
    action=$3
    #1 second delay
    delay=1000
    
    sar_delay=1
    
    file=${bench}_${action}_$6.perf
    

    remote_command=$4
    time_log=$5
    
    #Clean up any old instances
    killall perf 
    
    echo "===== $bench : $action ======"
    set_path
    toplev -l3 -I 1000 -x, -o $file bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command    
    
    bench=$bench
    action=$action
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}


### == end function definitions == ###
check_bdb_conf
vmpid=`ps -elf | grep BUS_2 | grep qemu | tr -s " " | cut -d " " -f 4`
time_log='benchmarks_time.log'
rm $time_log

profile="small" 

hadoop="2.10.0"
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


date >> "timings.txt"
vmpid=0
cleanup_bdb_cc
run_workload_toplev_bdb $vmpid "cc" "prep" "CC/genData-cc.sh $cc" $time_log $set
run_workload_toplev_bdb $vmpid "cc" "run" "CC/run-cc.sh $cc" $time_log $set
cleanup_bdb "cc"

run_workload_toplev_bdb $vmpid "fft0_5" "prep" "FFT/genData-fft.sh $fft_dim $fft_dim $fft_sparsity" $time_log $set
run_workload_toplev_bdb $vmpid "fft0_5" "run" "FFT/run-fft.sh $fft_dim $fft_dim $fft_sparsity" $time_log $set
cleanup_bdb "fft"

run_workload_toplev_bdb $vmpid "grep" "prep" "Grep/genData-grep.sh $grep" $time_log $set
run_workload_toplev_bdb $vmpid "grep" "run" "Grep/run-grep.sh $grep" $time_log $set
cleanup_bdb "grep"

run_workload_toplev_bdb $vmpid "matmult0_5" "prep" "MatrixMult/genData-matMult.sh $matmult_sparsity $matmult_dim $matmult_dim $matmult_dim" $time_log $set
run_workload_toplev_bdb $vmpid "matmult0_5" "run" "MatrixMult/run-matMult.sh $matmult_sparsity $matmult_dim $matmult_dim $matmult_dim" $time_log $set
cleanup_bdb "matMult"

run_workload_toplev_bdb $vmpid "md5" "prep" "MD5/genData-md5.sh $md5" $time_log $set
run_workload_toplev_bdb $vmpid "md5" "run" "MD5/run-md5.sh $md5" $time_log $set
cleanup_bdb "md5"
 
run_workload_toplev_bdb $vmpid "randsample" "prep" "randSample/genData-randSample.sh $randsample" $time_log $set
run_workload_toplev_bdb $vmpid "randsample" "run" "randSample/run-randSample.sh $randsample 0.5" $time_log $set
cleanup_bdb "randsample" 

run_workload_toplev_bdb $vmpid "sort" "prep" "Sort/genData-sort.sh $grep" $time_log $set
run_workload_toplev_bdb $vmpid "sort" "run" "Sort/run-terasort.sh $grep" $time_log $set
cleanup_bdb "terasort"

run_workload_toplev_bdb $vmpid "wc" "prep" "wordcount/genData-wc.sh $grep" $time_log $set
run_workload_toplev_bdb $vmpid "wc" "run" "wordcount/run-wordcount.sh $grep" $time_log $set
cleanup_bdb "wd"

date >> "timings.txt"
expunge


mkdir -p bdb_toplev/$hadoop/$profile/$set
mv *.perf bdb_toplev/$hadoop/$profile/$set
mv $time_log bdb_toplev/$hadoop/$profile/$set
mv *.csv bdb_toplev/$hadoop/$profile/$set
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/BigDataGeneratorSuite/Text_datagen/gsl-1.15/.libs/:disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/BigDataGeneratorSuite/Text_datagen/gsl-1.15/cblas/.libs/


# From BDB Paper: 
# Large is set to use all RAM. The other two are scaled down from that value.
# for matrix: 100, 1k, 10k 
# for FFT, 16kx16k, 32kx32k, 64kx64k
# for sparsity dependency for fft, 2 16384×16384 matrices, with 0.1 and 0.9 sparsity.
##
