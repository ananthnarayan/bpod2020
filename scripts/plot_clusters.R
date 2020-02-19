#Do kmeans plot
oldPar <- par()
count = 1    
files=c("metrics_sys.csv", "metrics_sys.csv" , "metrics_sys.csv")
fullData = data.frame()
vlines[0] = 0
for(i in 1:length(files))
{

    newData = read.csv(files[i])
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
    km = kmeans(fullData, 4, iter.max=10, nstart=1, algorithm="Lloyd")
    withCluster=cbind(metrics, km$cluster)
    colnames(withCluster)[7] = "Cluster"
    plot(x=c(1:nrow(withCluster)), y=km$cluster, type="l", )
    for(j in 1:count)
    {
        abline(v=vlines[j], lwd=3, lty=2)
    }
    
