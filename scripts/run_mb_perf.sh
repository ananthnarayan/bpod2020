#!/bin/bash

#Author: Ananth Narayan S
# Extract the benchmarks from within MineBench 3.0.1 which compile and execute
# properly. Write out the commands to get the benchmarks to run.
DMHOME=/home/ananth/MineBench/NU-MineBench-3.0.1
export DMHOME=$DMHOME
delay=500
perf_command="perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r02C0 -e r4f2e -e r412e -e r003C -e r01C2 -e r0108 -e r0185 -I $delay -x ','"

echo -e "====\nBayes\n"
eval "$perf_command -o bayes.perf $DMHOME/src/Bayesian/bayes/src/bci -F -wl -d $DMHOME/datasets/Bayesian/F26-A64-D250K_bayes.dom $DMHOME/datasets/Bayesian/F26-A64-D250K_bayes.tab $DMHOME/datasets/Bayesian/F26-A64-D250K_bayes.nbc"

echo -e "=====\nKmeans(edge)\n" 
eval "$perf_command -o kmeans_edge.perf $DMHOME/src/KMeans/example -i $DMHOME/datasets/kmeans/edge -b -o -f -p 4"

echo -e "=====\nKmeans(color)\n"
eval "$perf_command -o kmeans_color.perf $DMHOME/src/KMeans/example -i $DMHOME/datasets/kmeans/color -b -o -f -p 4"

echo -e "=====\nBirch\n"
eval "$perf_command -o birch.perf $DMHOME/src/BIRCH/birch $DMHOME/datasets/birch/AMR_256.para $DMHOME/datasets/birch/AMR_256.scheme $DMHOME/datasets/birch/AMR_256.proj $DMHOME/datasets/birch/particles_0_256_ascii"

echo -e "=====\nECLAT\n"
eval "$perf_command -o eclat.perf $DMHOME/src/ECLAT/eclat -i $DMHOME/datasets/ECLAT/ntrans_2000.tlen_20.nitems_1.npats_2000.patlen_6 -e 30 -s 0.0010"

#echo -e "=====\nPLSA\n"
# /usr/bin/time -p -o $filename -a  $DMHOME/src/PLSA/parasw.mt $DMHOME/datasets/PLSA/30k_1.txt $DMHOME/datasets/PLSA/30k_2.txt $DMHOME/datasets/PLSA/pam120.bla 600 400 3 3 1 4

echo -e "=====\nHop\n" 
eval "$perf_command -o hop.perf $DMHOME/src/HOP/para_hop 3900000  $DMHOME/datasets/HOP/particles_0_256 64 16 -1 4"

export OMP_NUM_THREADS=4
echo -e "=====\nRsearch\n"
eval "$perf_command -o rsearch.perf $DMHOME/src/RSEARCH/rsearch -n 1000 -c -E 10 -m $DMHOME/datasets/rsearch/matrices/RIBOSUM80-65.mat \
                              $DMHOME/datasets/rsearch/Queries/mir-40.stk \
                              $DMHOME/datasets/rsearch/Databasefile/100Kdb.fa"

echo -e "=====\nSVM\n"
eval "$perf_command -o svm.perf $DMHOME/src/SVM-RFE/svm_mkl $DMHOME/datasets/SVM-RFE/outData.txt 1000 15154 40"
