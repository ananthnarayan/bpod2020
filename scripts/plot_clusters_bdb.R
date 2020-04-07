
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
createDF<-function(files, separator)
{
    #First take a look at the perf data - microarchitectural.
    count = 1;
    vlines = array(0, length(files))
    fullData = data.frame()
    for(i in 1:length(files))
    {
        inputfile = files[i]
        #print(inputfile)
        newDataWithNA = read.csv(inputfile, sep=separator)
        newDataWithNA[newDataWithNA < 0] <- NA
        newDataWithNA[newDataWithNA == Inf] <- NA
        
        #newDataWithNA = newDataWithNA[, c(1:ncol(newDataWithNA))]
        
        newData <- na.omit(newDataWithNA)
        if(nrow(fullData) == 0)
        {
            fullData <- newData
        } else
        {
            fullData = rbind(fullData, newData)
        }
        rows = nrow(newData)
        if (count == 1)
        {
            vlines[count] = rows 
        } else {
            vlines[count] = rows + vlines[count - 1]
        }
        count=count + 1
    }
    return (list("fullData"=fullData, "vlines"=vlines));
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

currentDir=getwd()
setwd("~/Ananth/Research/research_code/scripts")
source("filenames_bdb.R")
source("functions.R")

base_workspace="/home/meena/Ananth/Research/research_code/results_workspace"
#currentDir=  "bdb/guest/2.10.0/small"
currentDir = "bdb/guest/3.2.1/small"

setwd(paste(base_workspace, currentDir, sep="/"))
perfHeader=c("IPC", "CacheMPKI", "BranchInstructionsRatio","BrancMispredictRatio","MemStores","MemLoads","LLCocc","TotalBytes","LocalBytes", "ContextSwitches", "PageFaults", "L1DReplacement", "L2Ref", "L2Miss")

plotPerfData(metrics_bdb_210_small_perf_files)
plotSarData(bdb_210_small_sar_files)
plotVirtData(bdb_210_small_virt_files)
all_perf_files = metrics_bdb_210_small_perf_files
all_sar_files = bdb_210_small_sar_files
all_virt_files = bdb_210_small_virt_files

#perf metrics, sar metrics, virt-top metrics
ret = createDF(metrics_bdb_210_small_perf_files, ",")
perfData = ret$fullData
perfVlines = ret$vlines
perfPCA=prcomp(perfData[ , c(1:14)], center=TRUE, scale=TRUE, retx=TRUE) 

ret = createDF(bdb_210_small_sar_files, ";") 
sarData = ret$fullData
sarVlines = ret$vlines
sarPCA=prcomp(sarData[,c(4:24)], center=TRUE, scale=TRUE, retx=TRUE) 

sarSOM<-som(scale(sarData[,c(4,5,6,7,8,9,16,18,19,22,24)]) )
#plot(sarSOM)
#summary(sarSOM)

numclusters = 4
sarKmeans = kmeans(sarData[,c(4,5,6,7,8,9,16,18,19,22,24)], numclusters, iter.max=100, nstart=1, algorithm="Lloyd")

sarWithCluster = cbind(sarData, sarKmeans$cluster)
toPlot=subset(sarWithCluster, sarWithCluster[["sarKmeans$cluster"]] == 4)


ret = createDF(bdb_210_small_virt_files, ",") 
virt_topData = ret$fullData
virtVlines=ret$vlines
virtPCA=prcomp(virt_topData[ , c(22,25,26)] , center=TRUE, scale=TRUE, retx=TRUE) 


colors <- function(n, alpha = 1) {
    rev(heat.colors(n, alpha))
}

#plot(sarSOM, type = "counts", palette.name = colors, heatkey = TRUE)
