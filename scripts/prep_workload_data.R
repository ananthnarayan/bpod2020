workspace="/home/meena/Ananth/Ananth-Research/research_code/results_workspace"
setwd(workspace)

#files=()

header="Instructions,FPInstructions,LLCRef,LLCMiss,Cycles,Uops,DTLBMiss,ITLBMiss"

#do a loop here.

    inputFile='sys.csv'
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
    
    #grep, sub
