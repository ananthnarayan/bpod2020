
library("hash")
library('tidyverse')
library('ggplot2')
library("kohonen")

saveAsPNG1<-function(pngfile, data1, main, xlab, ylab )
{
    png(pngfile)
    plot.new()
    data1 = na.omit(data1)
    plot(data1, type="l", main=main, xlab=xlab, ylab=ylab, ylim=c(0, max(data1)), na.rm=TRUE)
    dev.off()
}
saveAsPNG2<-function(data1, data2)
{
    png(pngfile)
    plot.new()
    plot(data1, type="l", main=main, xlab=xlab, ylab=ylab, ylim=c(0, max(data1)))
    dev.off()

}


plotPerfData <-function(perffiles)
{
    for( i in 1:length(perffiles))
    {
        file = perffiles[i]
        p<-read.csv(file)
        outbase = substr(file, 9, nchar(file) - 4)
        
        saveAsPNG1(pngfile=paste(outbase, "_", "ipc", ".png", sep=""), 
            data1=p[["IPC"]], 
            main=paste("IPC", outbase, sep=" "), 
            xlab="Time", 
            ylab="IPC")

        
        saveAsPNG1(pngfile=paste(outbase, "_", "cmpki", ".png", sep=""), 
            data1=p[["CacheMPKI"]] /(1024 * 1024), 
            main=paste("CacheMPKI", outbase, sep=" "), 
            xlab="Time", 
            ylab="Cache MPKI")

        saveAsPNG1(pngfile=paste(outbase, "_", "llcocc", ".png", sep=""), 
            data1=p[["LLCocc"]] /(1024 * 1024), 
            main=paste("LLC Occupancy", outbase, sep=" "), 
            xlab="Time", 
            ylab="Cache Occupancy (MB)")

        saveAsPNG1(pngfile=paste(outbase, "_", "mload", ".png", sep=""), 
            data1=p[["MemLoads"]], 
            main=paste("MemLoads", outbase, sep=" "), 
            xlab="Time", 
            ylab="Loads")
            
        saveAsPNG1(pngfile=paste(outbase, "_", "mstore", ".png", sep=""), 
            data1=p[["MemStores"]], 
            main=paste("MemStores", outbase, sep=" "), 
            xlab="Time", 
            ylab="Stores")

        saveAsPNG1(pngfile=paste(outbase, "_", "l2miss", ".png", sep=""), 
            data1=p[["L2Miss"]], 
            main=paste("L2Miss", outbase, sep=" "), 
            xlab="Time", 
            ylab="L2Miss")

        saveAsPNG1(pngfile=paste(outbase, "_", "l2ref", ".png", sep=""), 
            data1=p[["L2Ref"]], 
            main=paste("L2Ref", outbase, sep=" "), 
            xlab="Time", 
            ylab="L2Ref")     
            
        saveAsPNG1(pngfile=paste(outbase, "_", "l1d_rep", ".png", sep=""), 
            data1=p[["L1DReplacement"]], 
            main=paste("L1DReplacement", outbase, sep=" "), 
            xlab="Time", 
            ylab="Replacement")
    
        saveAsPNG1(pngfile=paste(outbase, "_", "localbytes", ".png", sep=""), 
            data1=p[["LocalBytes"]], 
            main=paste("LocalBytes", outbase, sep=" "), 
            xlab="Time", 
            ylab="Bytes(MB)")
    
        saveAsPNG1(pngfile=paste(outbase, "_", "totalbytes", ".png", sep=""), 
            data1=p[["TotalBytes"]], 
            main=paste("LocalBytes", outbase, sep=" "), 
            xlab="Time", 
            ylab="Bytes(MB)")
    
        saveAsPNG1(pngfile=paste(outbase, "_", "pagefaults", ".png", sep=""), 
            data1=p[["PageFaults"]], 
            main=paste("PageFaults", outbase, sep=" "), 
            xlab="Time", 
            ylab="Bytes(MB)")
    }
}

plotSarData<-function(sar_files)
{
    for( i in 1:length(sar_files))
    {
        file = sar_files[i]
        d <- read.csv(file, sep=";");

        outbase = substr(file, 10, nchar(file) - 4)
        
         saveAsPNG1(pngfile=paste(outbase, "_", "faults", ".png", sep=""), 
            data1=d$fault.s, 
            main=paste("sar/faults", outbase, sep=" "), 
            xlab="Time", 
            ylab="Faults")
    
        saveAsPNG1(pngfile=paste(outbase, "_", "swapin", ".png", sep=""), 
            data1=d[["pswpin.s"]], 
            main=paste("sar/pswpin", outbase, sep=" "), 
            xlab="Time", 
            ylab="Swapped in")


        saveAsPNG1(pngfile=paste(outbase, "_", "swapout", ".png", sep=""), 
            data1=d[["pswpout.s"]], 
            main=paste("sar/pswpout", outbase, sep=" "), 
            xlab="Time", 
            ylab="SwappedOut")
        

        saveAsPNG1(pngfile=paste(outbase, "_", "pgpgin", ".png", sep=""), 
            data1=d[["pgpgin.s"]], 
            main=paste("sar/pgpgin", outbase, sep=" "), 
            xlab="Time", 
            ylab="PG IN")
        
        saveAsPNG1(pngfile=paste(outbase, "_", "pgpgout", ".png", sep=""), 
            data1=d[["pgpgout.s"]], 
            main=paste("sar/pgpgin", outbase, sep=" "), 
            xlab="Time", 
            ylab="PG OUT")    
            
        saveAsPNG1(pngfile=paste(outbase, "_", "memused", ".png", sep=""), 
            data1=d[["kbmemused"]]/(1024), #convert to MB 
            main=paste("sar/kbmemused", outbase, sep=" "), 
            xlab="Time", 
            ylab="Mem used (MB)")

        saveAsPNG1(pngfile=paste(outbase, "_", "cached", ".png", sep=""), 
            data1=d[["kbcached"]]/(1024), #convert to MB 
            main=paste("sar/kbcached", outbase, sep=" "), 
            xlab="Time", 
            ylab="Mem cached (MB)")
 
         saveAsPNG1(pngfile=paste(outbase, "_", "dirty", ".png", sep=""), 
            data1=d[["kbdirty"]]/(1024), #convert to MB 
            main=paste("sar/kbdirty", outbase, sep=" "), 
            xlab="Time", 
            ylab="Mem Dirty (MB)")
            
            
        saveAsPNG1(pngfile=paste(outbase, "_", "buffers", ".png", sep=""), 
            data1=d[["kbbuffers"]]/(1024), #convert to MB 
            main=paste("sar/kbbuffers", outbase, sep=" "), 
            xlab="Time", 
            ylab="Buffer (MB)")
            
        print(paste(outbase, "kbbuffers", min(d[["kbbuffers"]]), max(d[["kbbuffers"]]), "kbcached", min(d[["kbcached"]]), max(d[["kbcached"]]), sep=","))
        
        saveAsPNG1(pngfile=paste(outbase, "_", "active", ".png", sep=""), 
            data1=d[["kbactive"]]/(1024), #convert to MB 
            main=paste("sar/kbactive", outbase, sep=" "), 
            xlab="Time", 
            ylab="Active (MB)")
            
    }

}

plotVirtData<-function(bdb_210_small_virt_files)
{
    for( i in 1:length(bdb_210_small_virt_files))
    {
        file = bdb_210_small_virt_files[i]
        d <- read.csv(file, sep=",");

        outbase = substr(file, 11, nchar(file) - 4)
        
        png(filename=paste(outbase, "_", "CPU", ".png", sep=""));
        plot(d[["X.CPU.1"]], type="l", main=paste("CPU", outbase, sep=" "), ylab="CPU")
        dev.off()
        
        png(filename=paste(outbase, "_", "Mem", ".png", sep=""));
        plot(d[["X.Mem"]], type="l", main=paste("Memory", outbase, sep=" "), ylab="Memory")
        dev.off()
        
        saveAsPNG1(pngfile=paste(outbase, "_", "RDBY", ".png", sep=""), 
            data1=d[["Block.RDBY"]], main=paste("Blocks RD", outbase, sep=" "), xlab="Time", ylab="Blocks RD"
            )
        
        saveAsPNG1(pngfile=paste(outbase, "_", "WRBY", ".png", sep=""), 
            data1=d[["Block.WRBY"]], main=paste("Blocks WR", outbase, sep=" "), xlab="Time", ylab="Blocks WR"
            )

    }
}

analysis<-function()
{

}

colors <- function(n, alpha = 1)
{
    rev(heat.colors(n, alpha))
}

currentDir=getwd()
setwd("~/Ananth/Research/research_code/scripts")
source("filenames_bdb.R")
source("functions.R")

base_workspace="/home/meena/Ananth/Research/research_code/results_workspace"
perfHeader=c("IPC", "CacheMPKI", "BranchInstructionsRatio","BrancMispredictRatio","MemStores","MemLoads","LLCocc","TotalBytes","LocalBytes", "ContextSwitches", "PageFaults", "L1DReplacement", "L2Ref", "L2Miss")


currentDir=  "bdb/host/2.10.0/small"
setwd(paste(base_workspace, currentDir, sep="/"))
plotPerfData(metrics_bdb_210_small_perf_files)
plotSarData(bdb_210_small_sar_files)

currentDir = "bdb/host/3.2.1/small"
setwd(paste(base_workspace, currentDir, sep="/"))
plotPerfData(metrics_bdb_321_small_perf_files)
plotSarData(bdb_321_small_sar_files)

