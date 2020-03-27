#!/bin/bash

set_remote_hadoop_home()
{
    HADOOP_HOME=/disk2/user/hadoops/
}
cleanup (){
	ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -rm -r /HiBench/$1 
}
cleanup_bdb () 
{
    ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -rm -r /hadoop/$1
}

expunge () {
    ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -expunge 
}

check_hibench_conf () {
    #hibench.scale.profile
    ssh user@192.168.122.23 -C head -n 10 /disk2/user/HiBench/conf/hibench.conf 
    #hibench.hadoop.home     /disk2/user/hadoops/hadoop-2.7.7
    ssh user@192.168.122.23 -C head -n 10 /disk2/user/HiBench/conf/hadoop.conf 
}

check_bdb_conf(){
}

run_remote_workload() {
    vmpid=$1
    bench=$2
    action=$3
    file=${bench}_${action}.perf
    remote_command=$4
    time_log=$5
    
    echo "===== $bench : $action ======"
    perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o $file -I 500 &
    perfprocess=$!
    
    command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout ssh user@192.168.122.23 -i id_rsa -C bash /disk2/user/HiBench/bin/workloads/$remote_command"
    
    eval $command
    time=`cat timeout` 
    kill -s SIGINT $perfprocess
    bench=$bench
    action=$action
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}

run_remote_workload_bdb() {
    vmpid=$1
    bench=$2
    action=$3
    file=${bench}_${action}.perf
    remote_command=$4
    time_log=$5
    
    echo "===== $bench : $action ======"
    perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o $file -I 500 &
    perfprocess=$!
    
    command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout ssh user@192.168.122.23 -i id_rsa -C bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command"
    
    eval $command
    time=`cat timeout` 
    kill -s SIGINT $perfprocess
    bench=$bench
    action=$action
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}

### == end function definitions == ###

vmpid=`ps -elf | grep BUS_2 | grep qemu | tr -s " " | cut -d " " -f 4`
time_log='benchmarks_time.log'
rm $time_log

echo "================="
profile="tiny"
hadoop="hadoop2.7"
echo "VM PID: $vmpid Profile:$profile" 
set_remote_hadoop_home 
echo "Current Hadoop Home is: $HADOOP_HOME"
#check_hibench_conf

run_remote_workload $vmpid "sort" "prep" "micro/sort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "sort" "run"     "micro/sort/hadoop/run.sh"      $time_log
cleanup "Sort"

run_remote_workload $vmpid "terasort" "prep" "micro/terasort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "terasort" "run"  "micro/terasort/hadoop/run.sh"      $time_log
cleanup "Terasort"

run_remote_workload $vmpid "wordcount" "prep" "micro/wordcount/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "wordcount" "run"  "micro/wordcount/hadoop/run.sh"      $time_log
cleanup "Wordcount"

#run_remote_workload $vmpid "sort" "prep" "ml/bayes/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "sort" "run"  "ml/bayes/hadoop/run.sh"      $time_log
#cleanup "Bayes"

#run_remote_workload $vmpid "sort" "prep" "ml/kmeans/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "sort" "run"  "ml/kmeans/hadoop/run.sh"      $time_log
#cleanup "Kmeans"

run_remote_workload $vmpid "aggregation" "prep" "sql/aggregation/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "aggregation" "run"  "sql/aggretation/hadoop/run.sh"      $time_log
cleanup "Aggregation"

run_remote_workload $vmpid "join" "prep" "sql/join/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "join" "run"  "sql/join/hadoop/run.sh"      $time_log
cleanup "Join"

run_remote_workload $vmpid "scan" "prep" "sql/scan/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "scan" "run"  "sql/scan/hadoop/run.sh"      $time_log
cleanup "Scan"

expunge

check_bdb_conf



case $profile in 
    "tiny")
        cc=8
        fft_dim=100
        fft_sparsity=0.5
        matmult_dim=100
        matmult_sparsity=0.5
        md5=1
        randsample=1
    ;;
    "small")
        cc=15
        fft_dim=100
        fft_sparsity=0.5
        matmult_dim=100
        matmult_sparsity=0.5
        md5=5
        randsample=5
    ;;
    "large")
        cc=18
        fft_dim=100
        fft_sparsity=0.5
        matmult_dim=100
        matmult_sparsity=0.5
        md5=10
        randsample=10
    ;;
    *)
        cc=8
        fft_dim=100
        fft_sparsity=0.5
        matmult_dim=100
        matmult_sparsity=0.5
        md5=1
        randsample=1
    ;;
esac 

run_remote_workload_bdb $vmpid "cc" "prep" "CC/genData-cc.sh $cc" $time_log
run_remote_workload_bdb $vmpid "cc" "run" "CC/run-cc.sh $cc" $time_log
cleanup_bdb "cc"

run_remote_workload_bdb $vmpid "fft0_5" "prep" "FFT/genData-fft.sh $fft $fft $fft_sparsity" $time_log
run_remote_workload_bdb $vmpid "fft0_5" "run" "FFT/run-fft.sh $fft $fft $fft_sparsity" $time_log
cleanup_bdb "fft"

run_remote_workload_bdb $vmpid "matmult0_5" "prep" "MatrixMult/genData-matMult.sh $matmult_sparsity $matmult $matmult $matmult" $time_log
run_remote_workload_bdb $vmpid "matmult0_5" "run" "MatrixMult/run-matMult.sh $matmult_sparsity $matmult $matmult $matmult" $time_log
cleanup_bdb "matMult"

run_remote_workload_bdb $vmpid "md5" "prep" "MD5/genData-md5.sh $md5" $time_log
run_remote_workload_bdb $vmpid "md5" "run" "MD5/run-md5.sh $md5" $time_log
cleanup_bdb "md5"
 
run_remote_workload_bdb $vmpid "randsample" "prep" "randSample/genData-randSample.sh $randsample" $time_log
run_remote_workload_bdb $vmpid "randsample" "run" "randSample/run-randSample.sh $randsample" $time_log
cleanup_bdb "randsample" 

expunge

mkdir -p $hadoop/$profile
mv *.perf $hadoop/$profile
mv $time_log $hadoop/$profile
