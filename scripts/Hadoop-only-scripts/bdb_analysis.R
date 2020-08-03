library("hash")
library('tidyverse')
library('ggplot2')
library("kohonen")
createDF<-function(files, separator)
{
    totalr=0
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
        
        #print(paste(inputfile, " " , nrow(newData)))
        totalr = totalr + nrow(newData)
        
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
    #print(totalr)
    return (list("fullData"=fullData, "vlines"=vlines));
}

currentDir=getwd()
setwd("~/Ananth/Research/research_code/scripts")
source("filenames_bdb.R")
source("functions.R")

base_workspace="/home/meena/Ananth/Research/research_code/results_workspace"

################
hdp="210"
currentDir=  "bdb/host/2.10.0/small"
setwd(paste(base_workspace, currentDir, sep="/"))

ret = createDF(metrics_bdb_210_small_perf_files, ",")
perf210Data = ret$fullData
perf210Vlines= ret[["vlines"]]

mydata<-perf210Data 
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, centers=i)$withinss)
png(filename=paste("perf_kmeans_", hdp, ".png"))

plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares", main="Perf")
dev.off()

#perf210Kmeans = kmeans(perf210Data, centers=8)
#perf210Data<-cbind(perf210Data, perf210Kmeans[["cluster"]])
#colnames(perf210Data)[ncol(perf210Data)] <- "cluster"

# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData$IPC , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData$CacheMPKI , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData[["MemLoads"]] , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData[["MemStores"]] , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData[["PageFaults"]] , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
#ggp = ggplot(perf210Data) + geom_point(aes(x=c(1:nrow(perf210Data)), y=perf210Data$cluster, col=perf210Data$cluster)) + scale_colour_gradientn(colours=rainbow(8));
#ggp = ggp + geom_vline(xintercept=perf210Vlines, linetype="dotted", color="black", size=1)
#plot (ggp);
###############
ret = createDF(bdb_210_small_sar_files, ";") 
sar210Data = ret$fullData #drop the first 4 columns
sar210Data = sar210Data[, c(5:ncol(sar210Data))]
sar210Vlines <- ret$vlines
mydata<-sar210Data
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var, na.rm=TRUE))
png(filename=paste("sar_kmeans_", hdp, ".png"))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                       centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares", main="Sar")
 dev.off()  

  
#sarKmeans = kmeans(mydata, centers=8)
#sar210Data<-cbind(sar210Data, sarKmeans[["cluster"]])
#colnames(sar210Data)[ncol(sar210Data)] <- "cluster"

#ggp = ggplot(sar210Data) + geom_point(aes(x=c(1:nrow(sar210Data)), y=sar210Data$cluster , col=sar210Data$cluster)) + scale_colour_gradientn(colours=rainbow(8))
#ggp = ggp + geom_vline(xintercept=sar210Vlines, linetype="dotted", color="black", size=1)
#plot (ggp);
###############################################################################################################

hdp="321"
currentDir = "bdb/host/3.2.1/small"
setwd(paste(base_workspace, currentDir, sep="/"))


ret = createDF(metrics_bdb_321_small_perf_files, ",")
perf321Data = ret$fullData
perf321Vlines= ret[["vlines"]]

mydata<-perf321Data 
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, centers=i)$withinss)
png(filename=paste("perf_kmeans_", hdp, ".png"))

plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares", main="Perf")
dev.off()

#perf321Kmeans = kmeans(perf321Data, centers=8)
#perf321Data<-cbind(perf321Data, perf321Kmeans[["cluster"]])
#colnames(perf321Data)[ncol(perf321Data)] <- "cluster"
#colnames(perfData) <- make.unique(names(perfData))

#ggp = ggplot(pData) + geom_point(aes(x=c(1:nrow(pData)), y=pData$LLCocc , col=pData$cluster)) + scale_colour_gradientn(colours=rainbow(8))
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData$IPC , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData$CacheMPKI , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData[["MemLoads"]] , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData[["MemStores"]] , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
# ggp = ggplot(perfData) + geom_point(aes(x=c(1:nrow(perfData)), y=perfData[["PageFaults"]] , col=perfData$cluster)) + scale_colour_gradientn(colours=rainbow(8));plot (ggp);
#ggp = ggplot(perf321Data) + geom_point(aes(x=c(1:nrow(perf321Data)), y=perf321Data$cluster,         col=perf321Data$cluster)) + #scale_colour_gradientn(colours=rainbow(8));
#ggp = ggp + geom_vline(xintercept=perf321Vlines, linetype="dotted", color="black", size=1)
#plot (ggp);
###############
ret = createDF(bdb_321_small_sar_files, ";") 
sar321Data = ret$fullData #drop the first 4 columns
sar321Data = sar321Data[, c(5:ncol(sar321Data))]
sar321Vlines=ret$vlines
mydata<-sar321Data
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var, na.rm=TRUE))
png(filename=paste("sar_kmeans_", hdp, ".png"))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,                                       centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares", main="Sar")
 dev.off()  

  
#sar321Kmeans = kmeans(sar321Data, centers=8)
#sar321Data<-cbind(sar321Data, sar321Kmeans[["cluster"]])
#colnames(sar321Data)[ncol(sar321Data)] <- "cluster"

#ggp = ggplot(sarData, ) + geom_point(aes(x=c(1:nrow(sarData)), y=sarData$kbmemfree , col=sarData$cluster)) + scale_colour_gradientn(colours=rainbow(8))
#ggp = ggplot(sar321Data, ) + geom_point(aes(x=c(1:nrow(sar321Data)), y=sar321Data$cluster , col=sar321Data$cluster)) + scale_colour_gradientn(colours=rainbow(8))
#ggp = ggp + geom_vline(xintercept=sar321Vlines, linetype="dotted", color="black", size=1)
#plot (ggp);
###########

allPerf = rbind(perf210Data, perf321Data)
allSar  =  rbind(sar210Data, sar321Data)

perfKmeans <- kmeans(allPerf, centers=8)
sarKmeans <- kmeans(allSar, centers=8)

allPerf<- cbind(allPerf, perfKmeans$cluster)
colnames(allPerf)[ncol(allPerf)] <- "cluster"


allSar<- cbind(allSar, sarKmeans$cluster)
colnames(allSar)[ncol(allSar)] <- "cluster"



ggp = ggplot(allSar) + geom_point(aes(x=c(1:nrow(allSar)), y=allSar$cluster , col=allSar$cluster)) + scale_colour_gradientn(colours=rainbow(8))
#ggp = ggplot(allSar) + geom_point(aes(x=c(1:nrow(allSar)), y=allSar$kbactive , col=allSar$cluster)) + scale_colour_gradientn(colours=rainbow(8))
ggp = ggp + geom_vline(xintercept=c(sar210Vlines, sar321Vlines + sar210Vlines[length(sar210Vlines)]), linetype="dotted", color="black", size=1)
plot (ggp);

allSar1 = allSar[c(1:sar210Vlines[length(sar210Vlines)]), ]
allSar2 = allSar[ c(sar210Vlines[length(sar210Vlines)]: nrow(allSar)), ]

ggp1 = ggplot(allSar1) + geom_point(aes(x=c(1:nrow(allSar1)), y=allSar1$X.commit, col=allSar1$cluster)) + scale_colour_gradientn(colours=rainbow(8), name="Cluster") + ggtitle("Hadoop 2.10.0") + xlab("Value") + ylab("Time")
ggp2 = ggplot(allSar2) + geom_point(aes(x=c(1:nrow(allSar2)), y=allSar2$X.commit, col=allSar2$cluster)) + scale_colour_gradientn(colours=rainbow(8), name="Cluster") + ggtitle("Hadoop 3.2.1") + xlab("Value") + ylab("Time")
multiplot(ggp1, ggp2) 

print(getwd())
ggsave("commit_clusters_210.png", plot=ggp1, device="png")
ggsave("commit_clusters_321.png", plot=ggp2, device="png")
# ggp = ggplot(allPerf) + geom_point(aes(x=c(1:nrow(allPerf)), y=allPerf$cluster , col=allPerf$cluster)) + scale_colour_gradientn(colours=rainbow(8))
# ggp = ggp + geom_vline(xintercept=c(perf210Vlines, perf321Vlines + perf210Vlines[length(perf210Vlines)] ), linetype="dotted", color="black", size=1)
# plot (ggp);
name = "New Legend Title"
#######################
# for ( i in 1:numclusters)
# {
#     perfkmeans = kmeans(perfData, numclusters, iter.max=100, nstart=1, algorithm="Lloyd")   
#     withinss[i] = sarKmeans[["withinss"]]
# }

# perfVlines = ret$vlines
# perfPCA=prcomp(perfData[ , c(1:14)], center=TRUE, scale=TRUE, retx=TRUE) 
# perfSom<-som(scale(perfData[,c(1:14)]), grid=somgrid(6,4,"hexagonal") )
# plot(perfSom, type="changes")
# plot(perfSom)
# 
# ret = createDF(bdb_210_small_sar_files, ";") 
# sarData = ret$fullData
# sarVlines = ret$vlines
# sarPCA=prcomp(sarData[,c(4:24)], center=TRUE, scale=TRUE, retx=TRUE) 
# 
# sarSOM<-som(scale(sarData[,c(4,5,6,7,8,9,16,18,19,22,24)]), grid=somgrid(6,4,"rectangular") )
# plot(sarSOM, type="changes")
# summary(sarSOM)
# 

# 
# plot(withinss, type="o")
# 
# sarWithCluster = cbind(sarData, sarKmeans$cluster)
# toPlot=subset(sarWithCluster, sarWithCluster[["sarKmeans$cluster"]] == 4)
# 
# plot(sarSOM, type="changes")
# plot(sarSOM, type = "counts", palette.name = colors, heatkey = TRUE)

# ret = createDF(bdb_210_small_virt_files, ",") 
# virt_topData = ret$fullData
# virtVlines=ret$vlines
# virtPCA=prcomp(virt_topData[ , c(22,25,26)] , center=TRUE, scale=TRUE, retx=TRUE) 
# 
