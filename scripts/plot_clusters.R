#Do kmeans plot
#oldPar <- par()
workspace="/home/meena/Ananth/Ananth-Research/research_code/results_workspace"
setwd(workspace)

count = 1    
files=c( "metrics_apsp.csv" , "metrics_bc.csv", "metrics_bfs.csv", "metrics_triangle.csv", "metrics_tsp.csv")
fullData = data.frame()
vlines = array(0, length(files))
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
    km = kmeans(fullData, 6, iter.max=10, nstart=1, algorithm="Forgy")
    withCluster=cbind(fullData, km$cluster)
    colnames(withCluster)[7] = "Cluster"
    plot(x=c(1:nrow(withCluster)), y=km$cluster,pch='+', col=4, ylim=c(0,6))
    for(j in 1:count)
    {
        abline(v=vlines[j], lwd=2, lty=2, col=2)
    }
    par(mfrow=c(2,3))
    plot(withCluster[["LLCMiss"]],      withCluster[["Cluster"]], pch=19, col=15, xlab="llcmiss")
    plot(withCluster[["Instructions"]], withCluster[["Cluster"]], pch=19, col=16, xlab="ipc")
    plot(withCluster[["FPInstructions"]], withCluster[["Cluster"]], pch=19, col=17, xlab="fp instructions")
    plot(withCluster[["Uops"]], withCluster[["Cluster"]], pch=19, col=18, xlab="uops")
    plot(withCluster[["DTLBMiss"]], withCluster[["Cluster"]], pch=19, col=19, xlab="dtlb")
    plot(withCluster[["ITLBMiss"]], withCluster[["Cluster"]], pch=19, col=20, xlab="itlb")
    
print(km$centers)
