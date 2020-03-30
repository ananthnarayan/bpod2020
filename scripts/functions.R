#functions
library('tidyverse')
library('ggplot2')

countPhaseDistribution<-function(dataset, numclusters)
{
    phasecount = array(data=0, dim=6)
    for (i in 1:numclusters)
    {
        phasecount[i] = nrow(subset(dataset, dataset$Cluster == i))
    }
    return (phasecount)
    
}
plotHist<-function(phaseCountFrame, title)
{
    ggplot(phaseCountFrame, aes(x=phase)) + geom_histogram(binwidth=1)
}

plotDistribution<-function(phaseCountFrame, title)
{
    phaseCountFrame$counts = 100 * phaseCountFrame$counts/sum(phaseCountFrame$counts)
    ggp = ggplot(phaseCountFrame, aes(x=phase, y=counts, fill=phase)) + geom_bar(stat="identity") 
    ggp = ggp + ggtitle(title) + xlab("Phase #") + ylab("%") + ylim(0, 100)
    return (ggp)
}
dokmeans<-function(metrics, numclusters)
{
    
    km = kmeans(metrics, numclusters, iter.max=100, nstart=1, algorithm="Lloyd")
    return(km)
}

plotBasic<-function(dataWithClusters, vlines, rows)
{
    ggp = ggplot(dataWithClusters) + geom_point(aes(x=c(1:rows), y=Cluster, col=Cluster))
}

plotWithVLines<-function(dataWithClusters, vlines, rows, title, numclusters)
{
    ggp = ggplot(dataWithClusters) + geom_point(aes(x=c(1:rows), y=Cluster, col=Cluster)) + ylim(0, numclusters)
    ggp = ggp + ggtitle(title) + xlab("Time") + ylab("Cluster")
    return (ggp);
}

