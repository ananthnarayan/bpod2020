currentDir=getwd()
setwd("~/Ananth/Ananth-Research/research_code/scripts")
source("filenames.R")
setwd(currentDir)

library('tidyverse')
library('ggplot2')

plotBasic<-function(dataWithClusters, vlines, rows)
{
    ggp = ggplot(dataWithClusters) + geom_point(aes(x=c(1:rows), y=Cluster, col=Cluster))
}

plotWithVLines<-function(dataWithClusters, vlines, rows, title)
{
    ggp = ggplot(dataWithClusters) + geom_point(aes(x=c(1:rows), y=Cluster, col=Cluster))
    #for(j in 1:length(vlines))
    #{
    #   ggp = ggp + geom_vline(xintercept = vlines[j], linetype="dotted", color="red", size=1)
    #}
    
    ggp = ggp + ggtitle(title) + xlab("Time") + ylab("Cluster")
    return (ggp);
}

dokmeans<-function(metrics, numclusters)
{
    
    km = kmeans(metrics, numclusters, iter.max=100, nstart=1, algorithm="Lloyd")
    return(km)
}
    base_workspace="/home/meena/Ananth/Ananth-Research/research_code/results_workspace/"
    setwd(base_workspace)
    
    all_files = c(
        paste(paths[[ "hibench_tiny" ]], metrics_tiny_filelist, sep="/"), 
        paste(paths[[ "hibench_small" ]], metrics_small_filelist, sep="/"), 
        paste(paths[[ "hibench_large" ]], metrics_large_filelist, sep="/")
        )
    prefix<- hash()
    #HiBench
    prefix["hibench_tiny"]="tiny"
    prefix["hibench_small"]="small"
    prefix["hibench_large"]="large"
    
    
    titles = c(
        paste(prefix[[ "hibench_tiny" ]],  substr(metrics_tiny_filelist,  1, nchar(metrics_tiny_filelist) - 4),  sep=":"), 
        paste(prefix[[ "hibench_small" ]], substr(metrics_small_filelist, 1, nchar(metrics_small_filelist) - 4), sep=":"), 
        paste(prefix[[ "hibench_large" ]], substr(metrics_large_filelist, 1, nchar(metrics_large_filelist) - 4), sep=":")
        )

    out_filenames =c( 
        paste(substr(metrics_tiny_filelist,   9, nchar(metrics_tiny_filelist) - 4),  "_", prefix[[ "hibench_tiny" ]],   sep=""), 
        paste(substr(metrics_small_filelist,  9, nchar(metrics_small_filelist) - 4),  "_", prefix[[ "hibench_small" ]], sep=""), 
        paste(substr(metrics_large_filelist,  9, nchar(metrics_large_filelist) - 4),  "_", prefix[[ "hibench_large" ]], sep="")
        )
        
    count = 1
    vlines = array(0, length(all_files))
    fullData = data.frame()
    count = 1
    for(i in 1:length(all_files))
    {
        inputfile = all_files[i]
        newDataWithNA = read.csv(inputfile)
        newDataWithNA = newDataWithNA[, c(2:ncol(newDataWithNA))]
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
    fd <-fullData
    #fd=fd[, c(1,2,4,7)]
    kmeansObject = dokmeans(fd, 6)
    withCluster=cbind(fd, kmeansObject$cluster)
    colnames(withCluster)[ncol(withCluster)] = "Cluster"
    
    #plot(plotWithVLines(withCluster, vlines, 14424))
    for( j in 1:length(vlines))
    {
        if (j == 1) start = 1
        else start = vlines[j - 1]
        end = vlines[j]
        filename=out_filenames[j]
        #print( paste("File: " , filename , " Title: " , titles[j]))
        p = plotWithVLines(withCluster[c(start:end), ], vlines, end - start + 1, titles[j])
        ggsave(paste(filename, "png", sep="."), p)
        #plot(plotWithVLines(withCluster[c(vlines[2]:vlines[3]), ], vlines, vlines[3]-vlines[2] + 1))
    }
