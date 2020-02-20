workspace="/home/meena/Ananth/Ananth-Research/research_code/results_workspace"
setwd(workspace)

#files=commandArgs(trailingOnly=TRUE)
files=c("apsp.csv", "bc.csv", "bfs.csv", "tsp.csv", "triangle.csv")
header="Instructions,FPInstructions,LLCRef,LLCMiss,Cycles,Uops,DTLBMiss,ITLBMiss"

#do a loop here.
for (i in 1:length(files))
{
    inputFile= files[i]
    print (paste("Processing : ", files[i]))
    inputFileDF = read.csv(inputFile, header=TRUE)
    ipc = inputFileDF['Instructions']/inputFileDF['Cycles']
    cacheMPKI = 1000 * inputFileDF['LLCMiss']/inputFileDF['Instructions']
    fpPercent = inputFileDF['FPInstructions']/inputFileDF['Instructions']
    uopsInst = inputFileDF['Uops']/inputFileDF['Instructions']
    dtlbMPKI = 1000 * inputFileDF['DTLBMiss']/inputFileDF['Instructions']
    itlbMPKI = 1000 * inputFileDF['ITLBMiss']/inputFileDF['Instructions']

    metrics = cbind(ipc, cacheMPKI, fpPercent, uopsInst, dtlbMPKI, itlbMPKI)
    outFile = paste('metrics', inputFile, sep="_")
    write.csv(metrics, outFile, quote=FALSE, row.names=FALSE)
 }   
    #grep, sub
