library("hash")
currentDir=getwd()
setwd("~/Ananth/Research/research_code/scripts")
source("filenames_bdb.R")

# eventNames['003c']='cycles'
# eventNames['00C0']='instructions'
# eventNames['00C4']='branch_instructions'
# eventNames['00c5']='branch_mispredicts'
# eventNames['0151']='l1d_replacement'
# eventNames['0480']='icache_ifdatastall' #do not use preferably
# eventNames['3f24']='l2_miss' #do not use preferably
# eventNames['412e']='llc_misses'
# eventNames['4f2e']='llc_references'
# eventNames['81d0']='mem_loads'
# eventNames['82d0']='mem_stores'
# eventNames['context-switches']='context_switches'
# eventNames['ef24']='l2_references' #do not use preferably
# eventNames['intel_cqm.llc_occupancy']='cache_occupancy'
# eventNames['intel_cqm.local_bytes']='local_bytes'
# eventNames['intel_cqm.total_bytes']='total_bytes'
# eventNames['page-faults']='page_faults'

prepareMetrics<-function(base_workspace, path, files, header)
{
    workspace=paste(base_workspace, path, sep="/")
    setwd(workspace)

    for (i in 1:length(files))
    {
        inputFile= files[i]
        inputFileDF = read.csv(inputFile, header=TRUE)
        
        ipc                 =   inputFileDF[['instructions']]/inputFileDF[['cycles']]
        cacheMPKI           =   1000 * inputFileDF[['llc_misses']]/inputFileDF[['instructions']]
        branchesPKI         =   1000 * inputFileDF[['branch_instructions']]/inputFileDF[['instructions']]
        branchMispredRatio  =   inputFileDF[['branch_mispredicts']]/inputFileDF[['branch_instructions']]
        l1dReplacementPKI   =   1000 * inputFileDF[['l1d_replacement']]/inputFileDF[['instructions']]
        memstoresPKI        =   1000 * inputFileDF[['mem_stores']]/inputFileDF[['instructions']]
        memloadsPKI         =   1000 * inputFileDF[['mem_loads']]/inputFileDF[['instructions']]
        l2refPKI            =   1000 * inputFileDF[['l2_references']]/inputFileDF[['instructions']]
        l2missPKI           =   1000 * inputFileDF[['l2_miss']]/inputFileDF[['instructions']]
        

        llcocc=inputFileDF[["cache_occupancy"]]
        totalbytes=inputFileDF[["total_bytes"]]
        localbytes=inputFileDF[["local_bytes"]]

        contextSwitches     =   inputFileDF[['context_switches']]
        pageFaults          =   inputFileDF[['page_faults']]

        
        metrics = cbind(ipc, cacheMPKI, branchesPKI, branchMispredRatio, memstoresPKI, memloadsPKI, llcocc, totalbytes, localbytes, contextSwitches, pageFaults, l1dReplacementPKI, l2refPKI, l2missPKI  )
        colnames(metrics)<-header
        outFile = paste('metrics', inputFile, sep="_")
        write.csv(metrics, outFile, quote=FALSE, row.names=FALSE)
    }
}

base_workspace="~/Ananth/Research/research_code/results_workspace"
setwd(base_workspace)
header=c("IPC", "CacheMPKI", "BranchInstructionsRatio","BrancMispredictRatio","MemStores","MemLoads","LLCocc","TotalBytes","LocalBytes", "ContextSwitches", "PageFaults", "L1DReplacement", "L2Ref", "L2Miss")

for(key in keys(paths))
{
    prepareMetrics(base_workspace, paths[[ key ]], fileslist [[ key ]], header)
}
setwd(currentDir)
