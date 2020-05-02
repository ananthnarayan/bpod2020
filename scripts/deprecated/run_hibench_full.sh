#!/bin/bash
HADOOP_HOME=
cleanup (){
	ssh user@192.168.122.99 -C $HADOOP_HOME/bin/hdfs dfs -rm -r /HiBench/$1 
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
    
    command="time -f %E,%e -o timeout ssh ananth@10.10.1.152 -C ls" #bash /disk2/user/HiBench/bin/workloads/$remote_command
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
#Microbenchmarks
time_log='hibench_time.log'
rm $time_log

echo "================="
profile="tiny"
echo "VM PID: $vmpid Profile:$profile" 


run_remote_workload $vmpid "sort" "prepare" "micro/sort/prepare/prepare.sh" $time_log
run_remote_workload $vmpid "sort" "run"     "micro/sort/hadoop/run.sh"      $time_log

#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o sort_prep.perf -I 500 &
#perfprocess=$!
#start=`date`
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/sort/prepare/prepare.sh
#end=`date`
#bench='sort'
#action="prep"
#echo -e "$bench,$action,$start,$end" >> $time_log
#kill -s SIGINT $perfprocess
#echo "Start sleep after prepare"
#sleep 10

# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o sort_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/sort/hadoop/run.sh
# end=`date`
# bench='sort'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# cleanup "Sort"
# echo "Start sleep after run"
# sleep 10
# 
# echo "=================" 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o terasort_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/terasort/prepare/prepare.sh
# end=`date`
# bench='terasort'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o terasort_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/terasort/hadoop/run.sh
# end=`date`
# bench='terasort'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# cleanup "Terasort" 
# echo "Start sleep after run"
# sleep 10
# 
# echo "================="
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o wordcount_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/wordcount/prepare/prepare.sh
# end=`date`
# bench='wordcount'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o wordcount_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/wordcount/hadoop/run.sh
# end=`date`
# bench='wordcount'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# cleanup "Wordcount"
# echo "Start sleep after run"
# sleep 10
# echo "================="
# 
# Machine learning
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o bayes_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/bayes/prepare/prepare.sh
# end=`date`
# bench='bayes'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o bayes_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/bayes/hadoop/run.sh
# end=`date`
# bench='bayes'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# cleanup "Bayes"
# echo "Start sleep after run"
# sleep 10
# echo "================="
# 
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o kmeans_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/kmeans/prepare/prepare.sh
# end=`date`
# bench='kmeans'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o kmeans_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/kmeans/hadoop/run.sh
# end=`date`
# bench='kmeans'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after run"
# cleanup "Kmeans"
# sleep 10
# echo "================="
# 
# 
# SQLv
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o aggregation_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/aggregation/prepare/prepare.sh
# end=`date`
# bench='aggregation'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o aggregation_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/aggregation/hadoop/run.sh
# end=`date`
# bench='aggregation'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# csortleanup "Aggregation"
# echo "Start sleep after run"
# sleep 10
# echo "================="
# 
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o join_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/join/prepare/prepare.sh
# end=`date`
# bench='join'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o join_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/join/hadoop/run.sh
# end=`date`
# bench='join'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# cleanup "Join"
# echo "Start sleep after run"
# sleep 10
# 
# echo "================="
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o scan_prep.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/scan/prepare/prepare.sh
# end=`date`
# bench='scan'
# action="prep"
# echo -e "$bench,$action,$start,$end" >> $time_log
# kill -s SIGINT $perfprocess
# echo "Start sleep after prepare"
# sleep 10
# 
# perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o scan_run.perf -I 500 &
# perfprocess=$!
# start=`date`
# ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/scan/hadoop/run.sh
# end=`date`
# bench='scan'
# action="run"
# echo -e "$bench,$action,$start,$end" >> $time_log
# cleanup "Scan"
# kill -s SIGINT $perfprocess
# sleep 10
# echo "================="
#web
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o nutchindexing_prep.perf -I 500 &
#perfprocess=$!
#echo "Perf process : $perfprocess"
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/nutchindexing/prepare/prepare.sh
#kill -s SIGINT $perfprocess
#echo "Start sleep after prepare"
#sleep 10
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o nutchindexing_run.perf -I 500 &
#perfprocess=$!
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/nutchindexing/hadoop/run.sh
#kill -s SIGINT $perfprocess
#sleep 10
##/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Nutchindexing
##sleep 5
#echo "================="
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o pagerank_prep.perf -I 500 &
#perfprocess=$!
#echo "Perf process : $perfprocess"
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/pagerank/prepare/prepare.sh
#kill -s SIGINT $perfprocess
#echo "Start sleep after prepare"
#sleep 10
#perf stat  -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o pagerank_run.perf -I 500 &
#perfprocess=$!
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/pagerank/hadoop/run.sh
#kill -s SIGINT $perfprocess
#sleep 10
##/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Pagerank
##sleep 5
#echo "================="
#mkdir $profile
mv *.perf $profile
