
#!bin/bash
#Author: Ishaan L

# wget http://prof.ict.ac.cn/bdb_uploads/bdb_5/packages/BigDataBench_V5.0_BigData_MicroBenchmark.tar.gz

# tar -zxvf BigDataBench_V5.0_BigData_MicroBenchmark.tar.gz

cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/

#./prepar.sh

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd Hadoop/Sort

#perf stat -d -d -d ./genData-sort.sh 1 -x '\n' -o ../../../Results/hadoop-sort-gen.data
perf stat -d -d -d -I 1000 -x ';' -o ../../../Results/hadoop-sort-gen.data ./genData-sort.sh 1
perf stat -d -d -d ./run-terasort.sh 1 -x '\n' -o ../../../Results/hadoop-sort.data

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/Spark/Sort

perf stat -d -d -d --output ~/Results/spark-sort-gen.data -x ';' -I 1000 ./genData-sort.sh 1  

perf stat -d -d -d --output ~/Results/spark-sort.data -x ';' -I 1000 ./runSpark-Sort.sh 1  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/Flink/sort-grep-wc

# perf stat -d -d -d -x --output ~/Results/flink-sort-gen.data -x ';' -I 1000 ./genData_Microbenchmarks.sh 

# perf stat -d -d -d -x --output ~/Results/flink-sort.data -x ';' -I 1000 ./run_Microbenchmarks.sh Sort 

# perf stat -d -d -d -x --output ~/Results/flink-wc.data -x ';' -I 1000 ./run_Microbenchmarks.sh Wordcount 

# perf stat -d -d -d -x --output ~/Results/flink-grep.data -x ';' -I 1000 ./run_Microbenchmarks.sh Grep  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_Sort

# perf stat -d -d -d -x --output ~/Results/ -x ';' -I 1000 ./genData_Sort.sh  mpich-sort-gen.data
# # Add user input

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_Grep

# perf stat -d -d -d -x --output ~/Results/ -x ';' -I 1000 ./genData_grep.sh  mpich-grep-gen.data
# # Add user input

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_WordCount

# perf stat -d -d -d -x --output ~/Results/ -x ';' -I 1000 ./genData_wordcount.sh  mpich-wc-gen.data
# # Add user input

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_MD5

# perf stat -d -d -d -x --output ~/Results/ -x ';' -I 1000 ./genData_md5.sh  mpich-md5-gen.data
# Add user input

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_Sort

# make

# perf stat -d -d -d mpirun -n 8 -x --output ~/Results/ -x ';' -I 1000 ./mpi_sort input_file output  mpich-sort.data

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_Sort

# make

# perf stat -d -d -d mpirun -n 8 -x --output ~/Results/ -x ';' -I 1000 ./mpi_grep input_file output  mpich-grep.data

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# cd /home/ishaan/Desktop/BDB/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/MPI_Sort

# make

# perf stat -d -d -d mpirun -n 8 -x --output ~/Results/ -x ';' -I 1000 ./mpi_wordcount input_file output  mpich-wc.data

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/CC

perf stat -d -d -d --output ~/Results/hadoop-cc-gen.data -x ';' -I 1000 ./genData-cc.sh 1000 

perf stat -d -d -d --output ~/Results/hadoop-cc.data -x ';' -I 1000 ./run-cc.sh 1000 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/Spark/CC

perf stat -d -d -d --output ~/Results/spark-cc-gen.data -x ';' -I 1000 ./genData-cc.sh 1000

perf stat -d -d -d --output ~/Results/spark-cc.data -x ';' -I 1000 ./runSpark-cc.sh 1000  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/randSample

perf stat -d -d -d --output ~/Results/hadoop-randSample-gen.data -x ';' -I 1000 ./genData-randSample.sh 1000  

perf stat -d -d -d --output ~/Results/hadoop-randSample.data -x ';' -I 1000 ./run-randSample.sh 1000 0.1  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/Spark/randSample

perf stat -d -d -d --output ~/Results/spark-randSample-gen.data -x ';' -I 1000 ./genData-randSample.sh 10000  

perf stat -d -d -d --output ~/Results/spark-randSample.data -x ';' -I 1000 ./runSpark-randSample.sh 10000  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

#cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/MPI/mpiRandSample

#perf stat -d -d -d --output ~/Results/mpich-randSample-gen.data -x ';' -I 1000 sh genData_randsample.sh  

#make

#perf stat -d -d -d mpirun -n 10 -x --output ~/Results/mpi-randSample.data -x ';' -I 1000 ./mpi-randsample data-randsample/lda_wiki1w_1 out 0.5 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

cd /home/ishaan/Desktop/BDB/BigDataGeneratorSuite/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/FFT

perf stat -d -d -d --output ~/Results/hadoop-fft-gen.data -x ';' -I 1000 ./genData-fft.sh 100 100 0.5  

perf stat -d -d -d --output ~/Results/hadoop-fft.data -x ';' -I 1000 ./run-fft.sh 100 100 0.5  

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
