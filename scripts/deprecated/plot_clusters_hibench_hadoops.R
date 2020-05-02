#hibench with 3 versions of hadoop
currentDir=getwd()
setwd("~/Ananth/Research/research_code/scripts")
source("filenames2.R")
source("functions.R")
setwd(currentDir)

library('tidyverse')
library('ggplot2')


    base_workspace="/home/meena/Ananth/Research/research_code/results_workspace/HiBench-21March"
    setwd(base_workspace)
    
    all_files = c(
        paste(paths[[ "hibench_27_tiny" ]] , metrics_hibench_27_tiny_filelist, sep="/"), 
        paste(paths[[ "hibench_27_small" ]], metrics_hibench_27_small_filelist, sep="/"), 
        paste(paths[[ "hibench_27_large" ]], metrics_hibench_27_large_filelist, sep="/"),

        paste(paths[[ "hibench_210_tiny" ]] , metrics_hibench_210_tiny_filelist, sep="/"), 
        paste(paths[[ "hibench_210_small" ]], metrics_hibench_210_small_filelist, sep="/"), 
        paste(paths[[ "hibench_210_large" ]], metrics_hibench_210_large_filelist, sep="/")

        paste(paths[[ "hibench_321_tiny" ]] , metrics_hibench_321_tiny_filelist, sep="/")
        paste(paths[[ "hibench_321_small" ]], metrics_hibench_321_small_filelist, sep="/") 
        paste(paths[[ "hibench_321_large" ]], metrics_hibench_321_large_filelist, sep="/")

        )
    prefix<- hash()
    #HiBench
    prefix["hibench_27_tiny"]      ="h27_tiny"
    prefix["hibench_27_small"]     ="h27_small"
    prefix["hibench_27_large"]     ="h27_large"
  

    prefix["hibench_210_tiny"]      ="h210_tiny"
    prefix["hibench_210_small"]     ="h210_small"
    prefix["hibench_210_large"]     ="h210_large"

    prefix["hibench_321_tiny"]      ="h321_tiny"
    prefix["hibench_321_small"]     ="h321_small"
    prefix["hibench_321_large"]     ="h321_large"

    titles = c(
        paste(prefix[[ "hibench_27_tiny" ]],  substr(metrics_hibench_27_tiny_filelist,  1, nchar(metrics_hibench_27_tiny_filelist) - 4),  sep=":"), 
        paste(prefix[[ "hibench_27_small" ]], substr(metrics_hibench_27_small_filelist, 1, nchar(metrics_hibench_27_small_filelist) - 4), sep=":"), 
        paste(prefix[[ "hibench_27_large" ]], substr(metrics_hibench_27_large_filelist, 1, nchar(metrics_hibench_27_large_filelist) - 4), sep=":"),

        paste(prefix[[ "hibench_210_tiny" ]],  substr(metrics_hibench_210_tiny_filelist,  1, nchar(metrics_hibench_210_tiny_filelist) - 4),  sep=":"), 
        paste(prefix[[ "hibench_210_small" ]], substr(metrics_hibench_210_small_filelist, 1, nchar(metrics_hibench_210_small_filelist) - 4), sep=":"), 
        paste(prefix[[ "hibench_210_large" ]], substr(metrics_hibench_210_large_filelist, 1, nchar(metrics_hibench_210_large_filelist) - 4), sep=":"),

        paste(prefix[[ "hibench_321_tiny" ]],  substr(metrics_hibench_321_tiny_filelist,  1, nchar(metrics_hibench_321_tiny_filelist) - 4),  sep=":"), 
        paste(prefix[[ "hibench_321_small" ]], substr(metrics_hibench_321_small_filelist, 1, nchar(metrics_hibench_321_small_filelist) - 4), sep=":"), 
        paste(prefix[[ "hibench_321_large" ]], substr(metrics_hibench_321_large_filelist, 1, nchar(metrics_hibench_321_large_filelist) - 4), sep=":")
        )

    out_filenames =c( 
        paste(substr(metrics_hibench_27_tiny_filelist,   9, nchar(metrics_hibench_27_tiny_filelist) - 4),   "_", prefix[[ "hibench_27_tiny" ]],  sep=""), 
        paste(substr(metrics_hibench_27_small_filelist,  9, nchar(metrics_hibench_27_small_filelist) - 4),  "_", prefix[[ "hibench_27_small" ]], sep=""), 
        paste(substr(metrics_hibench_27_large_filelist,  9, nchar(metrics_hibench_27_large_filelist) - 4),  "_", prefix[[ "hibench_27_large" ]], sep=""),

        paste(substr(metrics_hibench_210_tiny_filelist,   9, nchar(metrics_hibench_210_tiny_filelist) - 4),   "_", prefix[[ "hibench_210_tiny" ]],  sep=""), 
        paste(substr(metrics_hibench_210_small_filelist,  9, nchar(metrics_hibench_210_small_filelist) - 4),  "_", prefix[[ "hibench_210_small" ]], sep=""), 
        paste(substr(metrics_hibench_210_large_filelist,  9, nchar(metrics_hibench_210_large_filelist) - 4),  "_", prefix[[ "hibench_210_large" ]], sep=""),

        paste(substr(metrics_hibench_321_tiny_filelist,   9, nchar(metrics_hibench_321_tiny_filelist) - 4),   "_", prefix[[ "hibench_321_tiny" ]],  sep=""), 
        paste(substr(metrics_hibench_321_small_filelist,  9, nchar(metrics_hibench_321_small_filelist) - 4),  "_", prefix[[ "hibench_321_small" ]], sep=""), 
        paste(substr(metrics_hibench_321_large_filelist,  9, nchar(metrics_hibench_321_large_filelist) - 4),  "_", prefix[[ "hibench_321_large" ]], sep="")

        )
    numclusters = 6    
    count = 1
    vlines = array(0, length(all_files))
    fullData = data.frame()
    for(i in 1:length(all_files))
    {
        inputfile = all_files[i]
        #print(inputfile)
        newDataWithNA = read.csv(inputfile)
        newDataWithNA[newDataWithNA < 0] <- NA
        newDataWithNA[newDataWithNA == Inf] <- NA
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
    for(i in 1:nrow(fd))
    {
        if (fd[i, 1] > 3 )
            fd[i,1] = 3
        if(fd[i, 2] > 1000 )
            fd[i, 2] = 1000 
        if(fd[i, 3] > 1000 )
            fd[i, 3] = 1000
        if(fd[i, 4] > 2 )
            fd[i, 4] = 2    
    }

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
        
        p = plotWithVLines(withCluster[c(start:end), ], vlines, end - start + 1, titles[j], numclusters)
        ggsave(paste(filename, "png", sep="."), p)
        
        
        phasecount=countPhaseDistribution(withCluster[c(start:end),],  numclusters)
        phaseCountFrame <-data.frame(
            phase=c(1:6),
            counts=phasecount
        )
        
        #dp = plotDistribution(phaseCountFrame, titles[j])
        #ggsave(paste("dist_", filename, ".png", sep=""), dp)
        #plot(plotWithVLines(withCluster[c(vlines[2]:vlines[3]), ], vlines, vlines[3]-vlines[2] + 1))
    }
