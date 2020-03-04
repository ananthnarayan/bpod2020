#Do kmeans plot
#oldPar <- par()
library('ggplot2')
library('tidyverse')

workspace="/home/meena/Ananth/Ananth-Research/research_code/results_workspace/crono_mb_19feb2020"
setwd(workspace)

# plotGeneric()<-function(withCluster, vlines, rows)
# {
#     plot(x=c(1:nrow(withCluster)),withCluster[["Cluster"]],pch='+', col=4, ylim=c(0,6))
#     for(j in 1:length(vlines))
#     {
#         abline(v=vlines[j], lwd=2, lty=2, col=2)
#     }
# }
plotGG<-function(withCluster, vlines, rows)
{
    ggp = ggplot(withCluster) + geom_point(aes(x=c(1:rows), y=Cluster, col=Cluster))
    for(j in 1:length(vlines))
    {
        #    abline(v=vlines[j], lwd=2, lty=2, col=2)
        ggp = ggp + geom_vline(xintercept = vlines[j], linetype="dotted", color="red", size=2)
        
    }
    return (ggp);
}

count = 1    
files=c("apsp.csv","bc.csv","birch.csv","bfs.csv", "community.csv", "connected.csv", "tsp.csv", "pagerank.csv","sssp.csv","triangle.csv",
"bayes.csv","hop.csv","kmeans_edge.csv","rsearch.csv","svm.csv" ,"eclat.csv","kmeans_color.csv")
fullData = data.frame()
vlines = array(0, length(files))
for(i in 1:length(files))
{
    inputfile=paste("metrics", files[i], sep="_")
    #print(inputfile)
    newData = read.csv(inputfile)
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
    fd=fullData[, c(1,2,4,7)]
    km = kmeans(fd, 6, iter.max=50, nstart=1, algorithm="Lloyd")
    withCluster=cbind(fullData, km$cluster)
    colnames(withCluster)[ncol(withCluster)] = "Cluster"
    rows = nrow(withCluster)
    ggp = plotGG(withCluster, vlines, rows)
    plot(ggp)
    k# plot(x=c(1:nrow(withCluster)),withCluster[["Cluster"]],pch='+', col=4, ylim=c(0,6))
    # for(j in 1:length(vlines))
    # {
    #     abline(v=vlines[j], lwd=1, lty=2, col=2)
    # }

#
#   par(mfrow=c(2,4))
#   plot(withCluster[["LLCMiss"]],      withCluster[["Cluster"]], pch=19, col=15, xlab="llcmiss", ylab="Cluster id")
#   plot(withCluster[["Instructions"]], withCluster[["Cluster"]], pch=19, col=16, xlab="ipc", ylab="Cluster id")
#   plot(withCluster[["FPInstructions"]], withCluster[["Cluster"]], pch=19, col=17, xlab="fp instructions", ylab="Cluster id")
#   plot(withCluster[["Uops"]], withCluster[["Cluster"]], pch=19, col=18, xlab="uops", ylab="Cluster id")
#   plot(withCluster[["DTLBMiss"]], withCluster[["Cluster"]], pch=19, col=19, xlab="dtlb", ylab="Cluster id")
#   plot(withCluster[["ITLBMiss"]], withCluster[["Cluster"]], pch=19, col=20, xlab="itlb", ylab="Cluster id")
#   plot(withCluster[["llcocc"]], withCluster[["Cluster"]], pch=19, col=20, xlab="llcocc", ylab="Cluster id")
#   plot(withCluster[["totalbytes"]], withCluster[["Cluster"]], pch=19, col=20, xlab="totalb", ylab="Cluster id")
#   plot(withCluster[["localbytes"]], withCluster[["Cluster"]], pch=19, col=20, xlab="localb", ylab="Cluster id")
#
#The following lines plot the phase sequence for each workload in a separate plot.
    par(mfrow=c(2,4))
    for(i in 1:length(files))
    {
        if (i == 1) start = 1
        else start = vlines[i - 1]
        end = vlines[i] - 1
        sub=withCluster[c(start:end),]
        plot(x=c(1:nrow(sub)),y=sub[["Cluster"]],pch='+', col=4, ylim=c(0,6), main=files[i], ylab="Cluster ID", xlab="Time")
    }
