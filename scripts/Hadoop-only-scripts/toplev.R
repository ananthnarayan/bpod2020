
setwd("/home/meena/Ananth/Research/research_code/results_workspace/bdb/host/bdb_toplev")
path2="3.2.1/small/set1"
path1="2.10.0/small/set1"


aggregate<-function(file, path)
{
    toplevdata <- read.csv(paste(path, file, sep="/"))
    toplevdata = toplevdata[c(1: nrow(toplevdata) -1), c(1:4) ]
    groups = c("Frontend_Bound" , "Backend_Bound", "Bad_Speculation", "Retiring")
    colour=0
    time = 0
    currow = 0
    maxrow = nrow(toplevdata)
    prevMissing = 0
    maxtime  = floor(max(toplevdata[,1]))

    final = matrix(0, nrow=floor(max(toplevdata[,1])), ncol=length(groups))
    colnames(final) <- groups

    counts = matrix(0, nrow=floor(max(toplevdata[,1])), ncol=length(groups))
    colnames(counts) <- groups

    while(time < maxtime)
    {
            time  = time + 1
           # print(time)
            t = subset(toplevdata, floor(Timestamp) == time)
            trows = nrow(t)
            #print(currow)
            #print(trows)
            if(trows == 0)
            {
                next
            }
            for(sock in 0:1)
            {
                for (core in 0:7)
                {
                    sock_core =  paste("S", sock, "-C",core, sep="")
                    c = subset(t, CPUs == sock_core)
                    for(g in 1:4)
                    {
                        evt = groups[g]
                        e = subset(c, Area == evt)
                        if(nrow(e) != 0)
                        {
                            if(nrow(e) > 1)
                            {
                               # print (e);
                            final[time, evt] = final[time,evt] + min(e[, "Value"])
                            counts[time, evt] = counts[time, evt] + 1 

                                
                            }else{
                            final[time, evt] = final[time,evt] + e[["Value"]]
                            counts[time, evt] = counts[time, evt] + 1 
                            }
                        }
                    }
                    
                }
            }
            #final[time, evt] = final[time,evt]/count
            currow = currow + trows

    }
    final2 = final/counts
    final2[is.nan(final2)] = 0
    return (final2)
}


plotTopLev<-function(filename, f1, f2)
{
    groups = c("Frontend_Bound" , "Backend_Bound", "Bad_Speculation", "Retiring")
    png(filename, width=1080, height=1980, units="px")
    par(mfrow=c(2,1))
    barplot(t(f1), main="(2.10.0)", col=c(1,2,3,4), ylim=c(0,100))
    legend(0,-5, legend=groups, fill=c(1,2,3,4), col=c(1,2,3,4), xpd=TRUE, horiz=TRUE, box.lty=0)
    barplot(t(f2), main="(3.2.1)", col=c(1,2,3,4), ylim=c(0,100))
    legend(0,-5, legend=groups, fill=c(1,2,3,4), col=c(1,2,3,4), xpd=TRUE, horiz=TRUE, box.lty=0)

    dev.off()
}

files=c(
"cc_run_set1.perf",  
"fft0_5_run_set1.perf" , 
"grep_run_set1.perf" ,
"matmult0_5_run_set1.perf"  ,
"md5_run_set1.perf"  ,
"randsample_run_set1.perf",  
"sort_run_set1.perf" ,
"wc_run_set1.perf"

)
for(c in 1:length(files))
{
    file = files[c]
    f1 = aggregate(file, path1);
    f2 = aggregate(file, path2);
    base=substr(file, 1, nchar(file) - 4)
    filename=paste(base, "png", sep="")
    print(base)
    print(colMeans(f1))
    print(colMeans(f2))
    #plotTopLev(filename, f1, f2)
}

