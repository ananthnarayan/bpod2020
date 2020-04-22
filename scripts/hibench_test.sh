#!/bin/bash

set_remote_hadoop_home()
{
    HADOOP_HOME=/disk2/user/hadoops/hadoop-3.2.1
}
cleanup (){
	ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -rm -r /HiBench/$1 
}

expunge () {
    ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs dfs -expunge 
}

cleanup_bdb() {
	ssh user@192.168.122.23 -C $HADOOP_HOME/bin/hdfs fds -rm -r /hadoop/$1
}
check_hibench_conf () {
    #hibench.scale.profile
    ssh user@192.168.122.23 -C head -n 10 /disk2/user/HiBench/conf/hibench.conf 
    #hibench.hadoop.home     /disk2/user/hadoops/hadoop-2.7.7
    ssh user@192.168.122.23 -C head -n 10 /disk2/user/HiBench/conf/hadoop.conf 
}



run_remote_workload() {
    vmpid=$1
    bench=$2
    action=$3
    file=${bench}_${action}.perf
    remote_command=$4
    time_log=$5
    
    echo "===== $bench : $action ======"
    killall perf
    perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o $file -I 500 &
    perfprocess=$!
    sleep 1 
    command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout ssh user@192.168.122.23 -i id_rsa -C bash /disk2/user/HiBench/bin/workloads/$remote_command"
    
    eval $command
    time=`cat timeout` 
    kill -s SIGINT $perfprocess
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}

vmpid=`ps -elf | grep BUS_2 | grep qemu | tr -s " " | cut -d " " -f 4`
time_log='benchmark_time.log'
rm $time_log

echo "================="
profile="large"
hadoop="hadoop-3.2.1"

echo "VM PID: $vmpid Profile:$profile" 
killall perf
=======

### == end function definitions == ###

vmpid=`ps -elf | grep BUS_2 | grep qemu | tr -s " " | cut -d " " -f 4`
time_log='benchmarks_time.log'
rm $time_log

echo "================="
profile="tiny"
hadoop="hadoop2.7"
echo "VM PID: $vmpid Profile:$profile" 
>>>>>>> 101e46b39cd4151eb10424b2c4adde622aa910c2
set_remote_hadoop_home 
echo "Current Hadoop Home is: $HADOOP_HOME"
#check_hibench_conf

<<<<<<< HEAD
run_remote_workload $vmpid "sort" "prep" "micro/sort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "sort" "run"  "micro/sort/hadoop/run.sh"      $time_log
=======
run_remote_workload $vmpid "tinysort" "prep" "micro/sort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "tinysort" "run"     "micro/sort/hadoop/run.sh"      $time_log
>>>>>>> 101e46b39cd4151eb10424b2c4adde622aa910c2
cleanup "Sort"

run_remote_workload $vmpid "terasort" "prep" "micro/terasort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "terasort" "run"  "micro/terasort/hadoop/run.sh"      $time_log
cleanup "Terasort"

run_remote_workload $vmpid "wordcount" "prep" "micro/wordcount/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "wordcount" "run"  "micro/wordcount/hadoop/run.sh"      $time_log
cleanup "Wordcount"

<<<<<<< HEAD
#run_remote_workload $vmpid "bayes" "prep" "ml/bayes/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "bayes" "run"  "ml/bayes/hadoop/run.sh"      $time_log
#cleanup "Bayes"

#run_remote_workload $vmpid "kmeans" "prep" "ml/kmeans/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "kmeans" "run"  "ml/kmeans/hadoop/run.sh"      $time_log
#cleanup "Kmeans"

run_remote_workload $vmpid "aggregation" "prep" "sql/aggregation/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "aggregation" "run"  "sql/aggregation/hadoop/run.sh"      $time_log
cleanup "Aggregation"
#
=======
#run_remote_workload $vmpid "sort" "prep" "ml/bayes/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "sort" "run"  "ml/bayes/hadoop/run.sh"      $time_log
#cleanup "Bayes"

#run_remote_workload $vmpid "sort" "prep" "ml/kmeans/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "sort" "run"  "ml/kmeans/hadoop/run.sh"      $time_log
#cleanup "Kmeans"

run_remote_workload $vmpid "aggregation" "prep" "sql/aggregation/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "aggregation" "run"  "sql/aggretation/hadoop/run.sh"      $time_log
cleanup "Aggregation"

>>>>>>> 101e46b39cd4151eb10424b2c4adde622aa910c2
run_remote_workload $vmpid "join" "prep" "sql/join/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "join" "run"  "sql/join/hadoop/run.sh"      $time_log
cleanup "Join"

run_remote_workload $vmpid "scan" "prep" "sql/scan/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "scan" "run"  "sql/scan/hadoop/run.sh"      $time_log
<<<<<<< HEAD
#cleanup "Scan"

run_remote_workload $vmpid "nutchindexing" "prep" "websearch/nutchindexing/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "nutchindexing" "run"  "websearch/nutchindexing/hadoop/run.sh"      $time_log
#cleanup "Nutchindexing"

#run_remote_workload $vmpid "pagerank" "prep" "websearch/pagerank/prepare/prepare.sh" $time_log
#run_remote_workload $vmpid "pagerank" "run"   "websearch/pagerank/hadoop/run.sh"      $time_log
#cleanup "Pagerank"


expunge
mkdir -p $hadoop/$profile
mv *.perf $hadoop/$profile
mv $time_log $hadoop/$profile
=======
cleanup "Scan"

expunge


>>>>>>> 101e46b39cd4151eb10424b2c4adde622aa910c2
