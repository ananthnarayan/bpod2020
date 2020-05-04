
library("hash")
library('tidyverse')
library('ggplot2')
library("kohonen")

plotSarData2<-function(sar_files, path1, path2)
{
    colNames=unlist(strsplit("pswpin/s;pswpout/s;pgpgin/s;pgpgout/s;fault/s;majflt/s;pgfree/s;pgscank/s;pgscand/s;pgsteal/s;%vmeff;kbmemfree;kbmemused;%memused;kbbuffers;kbcached;kbcommit;%commit;kbactive;kbinact;kbdirty;kbanonpg;kbslab;kbkstack;kbpgtbl;kbvmused", ";"))
    c1 <-colNames[c(4:length(colNames))]; c1names = c1
    c2 <-colNames[c(4:length(colNames))]; c2names = c2

    for( i in 1:length(sar_files)) #for each benchmark
    {
        file = sar_files[i]
        file1 = paste(path1, sar_files[i], sep="/")
        file2 = paste(path2, sar_files[i], sep="/")
        
        d1 <- read.csv(file1, sep=";"); 
        d1<-d1[, 4:ncol(d1)]
        
        d2 <- read.csv(file2, sep=";"); 
        d2<-d2[, 4:ncol(d2)]
        
        outbase = substr(file, 1, nchar(file) - 4)
        legendText=c("2.10.0", "3.2.1")
        colNames = colnames(d1)
        
        #first 3 cols are hostname interva and timestamp
        for(c in 4:ncol(d1))
        {
            
            saveAsPNG2(pngfile=paste(outbase, "_", colNames[c], ".png", sep=""),
                data1=d1[,c], data2=d2[,c], main=colNames[c], 
                xlab="Time", ylab="#", legend=legendText
             )
        }
        
        c1<-rbind(c1, colMeans(d1[, 4:ncol(d1)]))
        c2<-rbind(c2, colMeans(d2[, 4:ncol(d2)]))

    }
    c1<-c1[-1,]
    c2<-c2[-1,]
    c1<-cbind(sar_files, c1)
    c2<-cbind(sar_files, c2)
        colnames(c1)<-c("bench", c1names)
    colnames(c2)<-c("bench", c2names)

    write.csv(c1, "~/c1.csv", quote=F)
    write.csv(c2, "~/c2.csv", quote=F)

}


plotSarData<-function(sar_files, path1, path2)
{
    for( i in 1:length(sar_files))
    {
        file1 = paste(path1, sar_files[i], sep="/")
        file2 = paste(path2, sar_files[i], sep="/")
        d1 <- read.csv(file1, sep=";");
        d2 <- read.csv(file2, sep=";");
        outbase = substr(file1, 10, nchar(file1) - 4)
        legend=c("2.10.0", "3.2.1")
        
         saveAsPNG1(pngfile=paste(outbase, "_", "faults", ".png", sep=""), 
            data1=d1$fault.s,  data2=d2$fault.s, 
            main=paste("sar/faults", outbase, sep=" "), 
            xlab="Time", 
            ylab="Faults")
    
        saveAsPNG1(pngfile=paste(outbase, "_", "swapin", ".png", sep=""), 
            data1=d1[["pswpin.s"]], data1=d1[["pswpin.s"]],
            main=paste("sar/pswpin", outbase, sep=" "), 
            xlab="Time", 
            ylab="Swapped in")


        saveAsPNG1(pngfile=paste(outbase, "_", "swapout", ".png", sep=""), 
            data1=d1[["pswpout.s"]], data1=d1[["pswpin.s"]],
            main=paste("sar/pswpout", outbase, sep=" "), 
            xlab="Time", 
            ylab="SwappedOut")
        

        saveAsPNG1(pngfile=paste(outbase, "_", "pgpgin", ".png", sep=""), 
            data1=d1[["pgpgin.s"]], data1=d1[["pswpin.s"]],
            main=paste("sar/pgpgin", outbase, sep=" "), 
            xlab="Time", 
            ylab="PG IN")
        
        saveAsPNG1(pngfile=paste(outbase, "_", "pgpgout", ".png", sep=""), 
            data1=d1[["pgpgout.s"]], 
            main=paste("sar/pgpgin", outbase, sep=" "), 
            xlab="Time", 
            ylab="PG OUT")    
            
        saveAsPNG1(pngfile=paste(outbase, "_", "memused", ".png", sep=""), 
            data1=d1[["kbmemused"]]/(1024), data1=d1[["pswpin.s"]], #convert to MB 
            main=paste("sar/kbmemused", outbase, sep=" "), 
            xlab="Time", 
            ylab="Mem used (MB)")

        saveAsPNG1(pngfile=paste(outbase, "_", "cached", ".png", sep=""), 
            data1=d1[["kbcached"]]/(1024), #convert to MB 
            main=paste("sar/kbcached", outbase, sep=" "), 
            xlab="Time", 
            ylab="Mem cached (MB)")
 
         saveAsPNG1(pngfile=paste(outbase, "_", "dirty", ".png", sep=""), 
            data1=d1[["kbdirty"]]/(1024), #convert to MB 
            main=paste("sar/kbdirty", outbase, sep=" "), 
            xlab="Time", 
            ylab="Mem Dirty (MB)")
            
            
        saveAsPNG1(pngfile=paste(outbase, "_", "buffers", ".png", sep=""), 
            data1=d1[["kbbuffers"]]/(1024), #convert to MB 
            main=paste("sar/kbbuffers", outbase, sep=" "), 
            xlab="Time", 
            ylab="Buffer (MB)")
            
        print(paste(outbase, "kbbuffers", min(d1[["kbbuffers"]]), max(d[["kbbuffers"]]), 
                             "kbcached", min(d[["kbcached"]]), max(d[["kbcached"]]), sep=","))
        
        saveAsPNG1(pngfile=paste(outbase, "_", "active", ".png", sep=""), 
            data1=d[["kbactive"]]/(1024), #convert to MB 
            main=paste("sar/kbactive", outbase, sep=" "), 
            xlab="Time", 
            ylab="Active (MB)")
            
    }

}


currentDir=getwd()
print(currentDir)
setwd("~/Ananth/Research/research_code/scripts")
source("filenames_bdb.R")
source("functions.R")

base_workspace="/home/meena/Ananth/Research/research_code/results_workspace/bdb/host/bdb_pidstat/iteration3"
#base_workspace="/home/meena/Ananth/Research/research_code/results_workspace/bdb/host/bdb_pidstat/iteration3"

#base_workspace="/home/meena/Ananth/Research/research_code/results_workspace/bdb/host/"
path1=  "2.10.0/small/set1"
path2 = "3.2.1/small/set1"

sar_files=c(
 "sar_cc_run.csv",
 "sar_fft0_5_run.csv", 
 "sar_grep_run.csv", 
 "sar_matmult0_5_run.csv", 
 "sar_md5_run.csv", 
 "sar_randsample_run.csv", 
 "sar_sort_run.csv", 
 "sar_wc_run.csv"
)


setwd(base_workspace)
plotSarData2(sar_files, path1, path2)


#=============\
 colNames=c("BLANK", "Time",  "UID",       "PID",  "minflt/s",  "majflt/s",     "VSZ",     "RSS",   "%MEM", "StkSize"  , "StkRef",  "Command")
# c1names <-colNames[c(7,8,10,11)]; 
# c2names <-colNames[c(7,8,10,11)];
plotPIDStatData2<-function(pidstat_files, path1, path2)
{
    colNames=c("BLANK", "Time",  "UID",       "PID",  "minflt/s",  "majflt/s",     "VSZ",     "RSS",   "%MEM", "StkSize"  , "StkRef",  "Command")
    c1 <-colNames[c(7,8,10,11)]; c1names = c1
    c2 <-colNames[c(7,8,10,11)]; c2names = c2
    for( i in 1:length(pidstat_files)) #for each benchmark
    {
        file = pidstat_files[i]
        file1 = paste(path1, pidstat_files[i], sep="/")
        file2 = paste(path2, pidstat_files[i], sep="/")
        d1 <- read.csv(file1, sep=",", header=FALSE);
        #colnames(d1)<-colNames
        d2 <- read.csv(file2, sep=",", header=FALSE);
        #colnames(d2)<-colNames
        #print(colnames(d1))

        outbase = substr(file, 1, nchar(file) - 4)
        legendText=c("2.10.0", "3.2.1")
        
        for(c in c(7,8,10,11))
        {
            saveAsPNG2(pngfile=paste(outbase, "_", colNames[c], ".png", sep=""),
                data1=d1[,c], data2=d2[,c], main=colNames[c], 
                xlab="Time", ylab="#", legend=legendText
             )
        }
        
        c1<-rbind(c1, colMeans(d1[, c(7,8,10,11)]))
        c2<-rbind(c2, colMeans(d2[, c(7,8,10,11)]))
    }

    c1<-c1[-1,]
    c2<-c2[-1,]
    colnames(c1)<-c("bench", c1names)
    colnames(c2)<-c("bench", c2names)
    c1<-cbind(pidstat_files, c1)
    c2<-cbind(pidstat_files, c2)
    print(c1)
    print(c2)
}

path1=  "2.10.0/small/set1"
path2 = "3.2.1/small/set1"

pidstat_files=c(
 "cc_run.pidstat.csv",
 "fft0_5_run.pidstat.csv", 
 "grep_run.pidstat.csv", 
 "matmult0_5_run.pidstat.csv", 
 "md5_run.pidstat.csv", 
 "randsample_run.pidstat.csv", 
 "sort_run.pidstat.csv", 
 "wc_run.pidstat.csv"
)
setwd(base_workspace)
plotPIDStatData2(pidstat_files, path1, path2)
