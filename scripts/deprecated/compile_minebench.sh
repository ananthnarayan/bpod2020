#! /bin/bash
# Author: Ananth


cd $DMHOME/src/APR
make
cd $DMHOME/src/ECLAT
make
cd $DMHOME/src/Bayesian/bayes/src
make
cd $DMHOME/src/ScalParC/
make
cd $DMHOME/src/BIRCH
make
cd $DMHOME/src/KMeans
make example
cd $DMHOME/src/HOP
make
#cd $DMHOME/src/SNP/pnl.snps/pnl/c_pgmtk/src
#make
#cd $DMHOME/src/SNP/pnl.snps/snp
#make
#cd $DMHOME/src/GeneNet/pnl.genenet/pnl_icc/c_pgmtk/src
#make
#cd $DMHOME/src/GeneNet/pnl.genenet/genenet
#make
#make -f Makefile.omp

#For a complete serial (non-parallel) version of semphy:
#cd $DMHOME/src/semphy
#make 
#rsearch: 
#Offered in two parallel flavors, based on OpenMP and MPI.
#For OpenMP version of rsearch,
#cd $DMHOME/src/rsearch/rsearch-1.1.src-OpenMP
#make
#For the MPI version of rsearch,
cd $DMHOME/src/RSEARCH/
./configure
make
cd $DMHOME/src/PLSA
make 
make -f Makefile.omp
cd $DMHOME/src/SVM-RFE
make -f makefile.omp

#utility_mine: 
cd $DMHOME/src/utility_mine/para_tran_utility
make
cd $DMHOME/src/AFI
#cd $DMHOME/src/geti
#make
#cd $DMHOME/src/getipp
#make
cd $DMHOME/src/Recursive_Weak
make
cd $DMHOME/src/Recursive_Weak_pp
make
#cd $DMHOME/src/ParETI
#make
