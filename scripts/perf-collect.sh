#!bin/bash
#Author: Ishaan L
wget http://prof.ict.ac.cn/bdb_uploads/bdb_5/packages/BigDataBench_V5.0_BigData_MicroBenchmark.tar.gz

tar -zxvf BigDataBench_V5.0_BigData_MicroBenchmark.tar.gz

cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/
./prepar.sh

cd Hadoop/Sort

perf stat -d -d -d ./genData-sort.sh 1 -x '\n' -o ../../../Results/hadoop-sort-gen.data

perf stat -d -d -d ./run-terasort.sh 1 -x '\n' -o ../../../Results/hadoop-sort.data

cd ../Spark/Sort

perf stat -d -d -d ./genData-sort.sh 1 -x '\n' -o ../../../Results/spark-sort-gen.data

perf stat -d -d -d ./runSpark-Sort.sh 1 -x '\n' -o ../../../Results/spark-sort.data

cd ../Flink/sort-grep-wc

perf stat -d -d -d ./genData_Microbenchmarks.sh -x '\n' -o ../../../Results/flink-sort-gen.data

perf stat -d -d -d ./run_Microbenchmarks.sh Sort -x '\n' -o ../../../Results/flink-sort.data

perf stat -d -d -d ./run_Microbenchmarks.sh Wordcount -x '\n' -o ../../../Results/flink-wc.data

perf stat -d -d -d ./run_Microbenchmarks.sh Grep -x '\n' -o ../../../Results/flink-grep.data

cd ../MPI/MPI_Sort

perf stat -d -d -d ./genData_Sort.sh -x '\n' -o ../../../Results/mpich-sort-gen.data
# Add user input
cd ../MPI/MPI_Grep

perf stat -d -d -d ./genData_grep.sh -x '\n' -o ../../../Results/mpich-grep-gen.data
# Add user input
cd ../MPI/MPI_WordCount

perf stat -d -d -d ./genData_wordcount.sh -x '\n' -o ../../../Results/mpich-wc-gen.data
# Add user input
cd ../MPI/MPI_MD5

perf stat -d -d -d ./genData_md5.sh -x '\n' -o ../../../Results/mpich-md5-gen.data
# Add user input

cd ../MPI/MPI_Sort

make

perf stat -d -d -d mpirun -n 8 ./mpi_sort input_file output -x '\n' -o ../../../Results/mpich-sort.data

cd ../MPI/MPI_Sort

make

perf stat -d -d -d mpirun -n 8 ./mpi_grep input_file output -x '\n' -o ../../../Results/mpich-grep.data

cd ../MPI/MPI_Sort

make

perf stat -d -d -d mpirun -n 8 ./mpi_wordcount input_file output -x '\n' -o ../../../Results/mpich-wc.data

cd ../../Hadoop/CC

perf stat -d -d -d ./genData-cc.sh 1000 -x '\n' -o ../../../Results/hadoop-cc-gen.data

perf stat -d -d -d ./run-cc.sh 1000 -x '\n' -o ../../../Results/hadoop-cc.data

cd ../../Spark/CC

perf stat -d -d -d ./genData-cc.sh 1000 -x '\n' -o ../../../Results/spark-cc-gen.data

perf stat -d -d -d ./runSpark-cc.sh 1000 -x '\n' -o ../../../Results/spark-cc.data
