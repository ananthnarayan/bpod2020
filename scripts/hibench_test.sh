#!/bin/bash

set_remote_hadoop_home()
{
    HADOOP_HOME=/disk2/user/hadoops/
}
cleanup (){
	ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -rm -r /HiBench/$1 
}
expunge () {
    ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -expunge 
}


run_remote_workload() {
    vmpid=$1
    bench=$2
    action=$3
    file=~/Results/HiBench/${bench}_${action}.perf
    remote_command=$4
    time_log=$5
    
    echo "===== $bench : $action ======"
    perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o $file -I 500 &
    perfprocess=$!
    
    command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout ssh user@192.168.122.23 -i id_rsa -C bash /disk2/user/HiBench/bin/workloads/$remote_command"
    
    eval $command
    time=`cat timeout` 
    kill -s SIGINT $perfprocess
    bench='sort'
    action="prep"
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}

vmpid=`ps -elf | grep BUS_2 | grep qemu | tr -s " " | cut -d " " -f 4`
time_log='hibench_time.log'
rm $time_log

echo "================="
profile="tiny"
echo "VM PID: $vmpid Profile:$profile" 

set_remote_hadoop_home 
echo "Current Hadoop Home is: $HADOOP_HOME"

run_remote_workload $vmpid "tinysort" "prep" "micro/sort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinysort" "run"     "micro/sort/hadoop/run.sh"      $time_log
cleanup "Sort"

run_remote_workload $vmpid "tinyterasort" "prep" "micro/terasort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinyterasort" "run"  "micro/terasort/hadoop/run.sh"      $time_log
cleanup "Terasort"

run_remote_workload $vmpid "tinywc" "prep" "micro/wordcount/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinywc" "run"  "micro/wordcount/hadoop/run.sh"      $time_log
cleanup "Wordcount"

run_remote_workload $vmpid "tinybayes" "prep" "ml/bayes/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinybayes" "run"  "ml/bayes/hadoop/run.sh"      $time_log
cleanup "Bayes"

run_remote_workload $vmpid "tinykmeans" "prep" "ml/kmeans/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinykmeans" "run"  "ml/kmeans/hadoop/run.sh"      $time_log
cleanup "Kmeans"

run_remote_workload $vmpid "tinyaggr" "prep" "sql/aggregation/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinyaggr" "run"  "sql/aggretation/hadoop/run.sh"      $time_log
cleanup "Aggregation"

run_remote_workload $vmpid "tinyjoin" "prep" "sql/join/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinyjoin" "run"  "sql/join/hadoop/run.sh"      $time_log
cleanup "Join"

run_remote_workload $vmpid "tinyscan" "prep" "sql/scan/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinyscan" "run"  "sql/scan/hadoop/run.sh"      $time_log
cleanup "Scan"

run_remote_workload $vmpid "tinynutch" "prep" "websearch/nutchindexing/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinynutch" "run"  "websearch/nutchindexing/hadoop/run.sh"      $time_log
cleanup "Nutchindexing"

run_remote_workload $vmpid "tinypr" "prep" "websearch/pagerank/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinypr" "run"   "websearch/pagerank/run.sh"      $time_log
cleanup "Pagerank"
