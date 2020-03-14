#!/bin/bash
vmpid=`ps -elf | grep centos-bdb | grep qemu | tr -s " " | cut -d " " -f 4`
profile="tiny"
echo "VM Pid: $vmpid Profile:$profile"

echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o cc_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/CC/genData-cc.sh 100
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o cc_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/CC/run-cc.sh 100
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o fft_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT/genData-fft.sh 100 100 0.5 
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o  fft_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT/run-fft.sh 100 100 0.5
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o fft_0_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT/genData-fft.sh 100 100 0 
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o  fft_0_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT/run-fft.sh 100 100 0
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o fft_1_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT/genData-fft.sh 100 100 1 
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o  fft_1_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT/run-fft.sh 100 100 1
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10

echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o grep_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/Grep/genData-grep.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o grep_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/Grep/run-grep.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10

echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o matmul_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MatrixMult/genData-matMult.sh 0.5 100 100 100
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o matmul_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MatricMult/run-matMult.sh 0.5 100 100 100
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o matmul_0_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MatrixMult/genData-matMult.sh 0 100 100 100
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o matmul_0_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MatricMult/run-matMult.sh 0 100 100 100
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o matmul_1_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MatrixMult/genData-matMult.sh 1 100 100 100
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o matmul_1_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MatricMult/run-matMult.sh  100 100 100
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o md5_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MD5/genData-md5.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o md5_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/MD5/run-md5.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o randsample_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/randSample/genData-randSample.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o randsample_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/randSample/run-randSample.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10

echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o sort_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/Sort/genData-sort.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o sort_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/Sort/run-sort.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10


echo "==========================="
perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o wordcount_prep.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/wordcount/genData-wc.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after prep"
sleep 10

perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -p $vmpid -x "," -o wordcount_run.perf -I 500 &
perfprocess=$!
echo "Perf process: $perfprocess"
ssh user@192.168.122.39 -i ~/.ssh/id_rsa -C /home/user/bdb/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/wordcount/run-wc.sh 1
kill -s SIGINT $perfprocess
echo "Starting sleep after run"
sleep 10
