library("hash")
currentDir=getwd()
setwd("~/Ananth/Ananth-Research/research_code/scripts")
source("filenames_hibench_hadoop_preprun.R")

prepareMetrics<-function(base_workspace, path, files, header)
{
    workspace=paste(base_workspace, path, sep="/")
    setwd(workspace)

    for (i in 1:length(files))
    {
        inputFile= files[i]
        inputFileDF = read.csv(inputFile, header=TRUE)
        #print (paste("COmpleted processing : ", workspace, " " , files[i]))
        ipc = inputFileDF[['Instructions']]/inputFileDF[['Cycles']]
        cacheMPKI = 1000 * inputFileDF[['LLCMiss']]/inputFileDF[['Instructions']]
        branchInstRatio = 1000 * inputFileDF[['BranchInstructions']]/inputFileDF[['Instructions']]
        branchMispredRatio = inputFileDF[['BranchMispredicts']]/inputFileDF[['BranchInstructions']]
        dtlbMPKI = 1000 * inputFileDF[['DTLBMiss']]/inputFileDF[['Instructions']]
        itlbMPKI = 1000 * inputFileDF[['ITLBMiss']]/inputFileDF[['Instructions']]
        
        llcocc=inputFileDF[["LLCOcc"]]
        totalbytes=inputFileDF[["TotalBytes"]]
        localbytes=inputFileDF[["LocalBytes"]]
        metrics = cbind(ipc, cacheMPKI, branchInstRatio, branchMispredRatio, dtlbMPKI, itlbMPKI, llcocc , totalbytes, localbytes )
        colnames(metrics)<-header
        outFile = paste('metrics', inputFile, sep="_")
        write.csv(metrics, outFile, quote=FALSE, row.names=FALSE)
    }
}

base_workspace="~/Ananth/Ananth-Research/research_code/results_workspace/HiBench-24March/march-24"
setwd(base_workspace)
header=c("IPC", "CacheMPKI", "BranchInstructionsRatio","BrancMispredictRatio","DTLBMPKI","ITLBMPKI","LLCocc","TotalBytes","LocalBytes")

for(key in keys(paths))
{
    prepareMetrics(base_workspace, paths[[ key ]], fileslist [[ key ]], header)
}
setwd(currentDir)
