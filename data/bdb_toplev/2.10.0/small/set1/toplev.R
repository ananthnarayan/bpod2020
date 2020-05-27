setwd("/home/meena/Ananth/Research/research_code/results_workspace/bdb_toplev/3.2.1/small/set1")
toplevdata <- read.csv("sort_run_set1.perf")
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
                            print (e);
                        final[time, evt] = final[time,evt] + max(e[, "Value"])
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

barplot(t(final2), main="hadoop 3.x", col=c(1,2,3,4))
# for( g in 1:length(groups))
# {
#     groupData <- subset(toplevdata, (toplevdata[,3]== groups[g]))
#     colour = colour + 1
#     for( i in 0:1)
#     {
#         for (j in 0:7)
#         {
#             core = paste("S", i, "-C",j, sep="")
#             coreSubset<-subset(groupData, groupData[,2] == core)
#             if(i == 0)
#             {
#                 socket0 = matrix(0, nrow(coreSubset),1)
#                 socket0[,1] = coreSubset[["Value"]]
#                 
#             }
#             else 
#             {
#                 socket1 = matrix(0, nrow(coreSubset),1)
#                 socket1[, 1] = coreSubset[["Value"]]
#             }
#         }
#     }
#     plot( rowSums(socket0), col=colour, lty=1)
#     lines( rowSums(socket1) , col=colour, lty=2)
# }
