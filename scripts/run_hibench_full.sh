#!/bin/bash

vmpid=`ps -elf | grep BUS_2 | grep qemu | tr -s " " | cut -d " " -f 4`
#This is not an efficient script... :D
#Microbenchmarks
echo "================="

profile="huge"
echo "VM PID: $vmpid Profile:$profile" 
#bash /disk2/user/HiBench/bin/workloads/micro/dfsioe/prepare/prepare.sh
#sleep 10
#bash /disk2/user/HiBench/bin/workloads/micro/dfsioe/hadoop/run.sh
#sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Dfsioe
#sleep 5
echo "================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o sort_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/sort/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o sort_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/sort/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
##sleep 5
echo "=================" 
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o terasort_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/terasort/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o terasort_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/terasort/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Terasort
#sleep 5

echo "================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o wordcount_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/wordcount/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o wordcount_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/micro/wordcount/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Wordcount
#sleep 5
echo "================="
#Machine learning
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o bayes_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/bayes/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o bayes_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/bayes/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Bayes
#sleep 5
echo "================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o kmeans_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/kmeans/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o kmeans_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/ml/kmeans/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Kmeans
#sleep 5
echo "================="
#SQLv
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o aggregation_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/aggregation/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o aggregation_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/aggregation/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Sql
#sleep 5
echo "================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o join_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/join/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o join_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/join/hadoop/run.sh
kill -s SIGINT $perfprocess
echo "Start sleep after run"
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Sql
#sleep 5
echo "================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o scan_prep.perf -I 500 &
perfprocess=$!
echo "Perf process : $perfprocess"
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/scan/prepare/prepare.sh
kill -s SIGINT $perfprocess
echo "Start sleep after prepare"
sleep 10
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o scan_run.perf -I 500 &
perfprocess=$!
ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/sql/scan/hadoop/run.sh
kill -s SIGINT $perfprocess
sleep 10
#/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Sql
#sleep 5
echo "================="
#web
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o nutchindexing_prep.perf -I 500 &
#perfprocess=$!
#echo "Perf process : $perfprocess"
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/nutchindexing/prepare/prepare.sh
#kill -s SIGINT $perfprocess
#echo "Start sleep after prepare"
#sleep 10
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o nutchindexing_run.perf -I 500 &
#perfprocess=$!
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/nutchindexing/hadoop/run.sh
#kill -s SIGINT $perfprocess
#sleep 10
##/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Nutchindexing
##sleep 5
#echo "================="
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o pagerank_prep.perf -I 500 &
#perfprocess=$!
#echo "Perf process : $perfprocess"
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/pagerank/prepare/prepare.sh
#kill -s SIGINT $perfprocess
#echo "Start sleep after prepare"
#sleep 10
#perf stat  -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o pagerank_run.perf -I 500 &
#perfprocess=$!
#ssh user@192.168.122.99 -C bash /disk2/user/HiBench/bin/workloads/websearch/pagerank/hadoop/run.sh
#kill -s SIGINT $perfprocess
#sleep 10
##/home/user/hadoop-2.10.0/bin/hdfs dfs  -rm -R HiBench/Pagerank
##sleep 5
#echo "================="
#mkdir $profile
mv *.perf $profile
