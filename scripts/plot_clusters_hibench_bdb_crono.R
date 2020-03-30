#hibench, bdb, and crono
currentDir=getwd()
setwd("~/Ananth/Ananth-Research/research_code/scripts")
source("filenames.R")
source("functions.R")
setwd(currentDir)

library('tidyverse')
library('ggplot2')

    base_workspace="/home/meena/Ananth/Ananth-Research/research_code/results_workspace/HiBenchAndBDB-18Mar2020/"
    setwd(base_workspace)
    
    all_files = c(
        paste(paths[[ "hibench_tiny" ]] , metrics_hibench_tiny_filelist, sep="/"), 
        paste(paths[[ "hibench_small" ]], metrics_hibench_small_filelist, sep="/"), 
        paste(paths[[ "hibench_large" ]], metrics_hibench_large_filelist, sep="/"),
        paste(paths[[ "crono_sparse" ]] , metrics_crono_sparse_filelist, sep="/"),
        paste(paths[[ "crono_dense" ]]  , metrics_crono_dense_filelist, sep="/"),
        paste(paths[[ "bdb_tiny"    ]], metrics_bdb_tiny_filelist, sep="/"),
        paste(paths[[ "bdb_large"    ]], metrics_bdb_large_filelist, sep="/")
        )
    prefix<- hash()
    #HiBench
    prefix["hibench_tiny"]      ="hibench_tiny"
    prefix["hibench_small"]     ="hibench_small"
    prefix["hibench_large"]     ="hibench_large"
    prefix["crono_dense"]       ="crono_dense"
    prefix["crono_sparse"]      ="crono_sparse"
    prefix["bdb_tiny"]          = "bdb_tiny"
    prefix["bdb_large"]         = "bdb_large"
    
    titles = c(
        paste(prefix[[ "hibench_tiny" ]],  substr(metrics_hibench_tiny_filelist,  1, nchar(metrics_hibench_tiny_filelist) - 4),  sep=":"), 
        paste(prefix[[ "hibench_small" ]], substr(metrics_hibench_small_filelist, 1, nchar(metrics_hibench_small_filelist) - 4), sep=":"), 
        paste(prefix[[ "hibench_large" ]], substr(metrics_hibench_large_filelist, 1, nchar(metrics_hibench_large_filelist) - 4), sep=":"),
        paste(prefix[[ "crono_sparse"  ]], substr(metrics_crono_sparse_filelist,  1, nchar(metrics_crono_sparse_filelist) - 4),  sep=":"),
        paste(prefix[[ "crono_dense"   ]], substr(metrics_crono_dense_filelist,   1, nchar(metrics_crono_dense_filelist) - 4),  sep=":"),
        paste(prefix[[ "bdb_tiny"      ]], substr(metrics_bdb_tiny_filelist,      1, nchar(metrics_bdb_tiny_filelist) - 4),  sep=":"),
        paste(prefix[[ "bdb_large"     ]], substr(metrics_bdb_large_filelist,     1, nchar(metrics_bdb_large_filelist) - 4),  sep=":")
        
        )

    out_filenames =c( 
        paste(substr(metrics_hibench_tiny_filelist,   9, nchar(metrics_hibench_tiny_filelist) - 4),   "_", prefix[[ "hibench_tiny" ]],  sep=""), 
        paste(substr(metrics_hibench_small_filelist,  9, nchar(metrics_hibench_small_filelist) - 4),  "_", prefix[[ "hibench_small" ]], sep=""), 
        paste(substr(metrics_hibench_large_filelist,  9, nchar(metrics_hibench_large_filelist) - 4),  "_", prefix[[ "hibench_large" ]], sep=""),
        paste(substr(metrics_crono_sparse_filelist,   9, nchar(metrics_crono_sparse_filelist) - 4),   "_", prefix[[ "crono_sparse" ]],  sep=""),
        paste(substr(metrics_crono_dense_filelist,    9, nchar(metrics_crono_dense_filelist) - 4),    "_", prefix[[ "crono_dense" ]],   sep=""),
        paste(substr(metrics_bdb_tiny_filelist,       9, nchar(metrics_bdb_tiny_filelist) - 4),       "_", prefix[[ "bdb_tiny" ]],      sep=""),
        paste(substr(metrics_bdb_large_filelist,      9, nchar(metrics_bdb_large_filelist) - 4),      "_", prefix[[ "bdb_large" ]],     sep="")

        )
    numclusters = 6    
    count = 1
    vlines = array(0, length(all_files))
    fullData = data.frame()
    count = 1
    for(i in 1:length(all_files))
    {
        inputfile = all_files[i]
        newDataWithNA = read.csv(inputfile)
        
        newDataWithNA[newDataWithNA < 0 ] <- NA
        newDataWithNA[newDataWithNA == Inf] <- NA
        newDataWithNA = newDataWithNA[, c(1:ncol(newDataWithNA))]
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
        
        
        phasecount=countPhaseDistribution(withCluster[c(start:end),],  6)
        phaseCountFrame <-data.frame(
            phase=c(1:6),
            counts=phasecount
        )
        
        dp = plotDistribution(phaseCountFrame, titles[j])
        ggsave(paste("dist_", filename, ".png", sep=""), dp)
        #plot(plotWithVLines(withCluster[c(vlines[2]:vlines[3]), ], vlines, vlines[3]-vlines[2] + 1))
    }

    
# plt <- ggplot(pcf, aes(x=phase, y=counts, fill=phase)) + geom_bar(stat="identity", width=1)
# plot(plt)
# pie <- plt + coord_polar("y", start=0)
# plot(pie)

