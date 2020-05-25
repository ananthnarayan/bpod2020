library("hash")
currentDir=getwd()
setwd("~/Ananth/Research/research_code/scripts")
source("functions.R")

prepareMetrics<-function(base_workspace, path1, path2, perf_file, tlb_file)
{
    
    d210_perf = read.csv(paste(path1, perf_file, sep="/"));
    d210_tlb = read.csv(paste(path1, tlb_file, sep="/"));
    d321_perf = read.csv(paste(path2, perf_file, sep="/"));
    d321_tlb = read.csv(paste(path2, tlb_file, sep="/"));
    
    d210_rows = min(nrow(d210_perf), nrow(d210_tlb))
    d321_rows = min(nrow(d321_perf), nrow(d321_tlb))
    
    
    d210 = d210_tlb[1:d210_rows, 2:ncol(d210_tlb)]
    d210_inst = d210_perf[1:d210_rows, "instructions"]
    d210_ratios = 1000 * d210/d210_inst

     
    d321 = d321_tlb[1:d321_rows, 2:ncol(d321_tlb)]
    d321_inst = d321_perf[1:d321_rows, "instructions"]
    d321_ratios = 1000 * d321/d321_inst

   for(i in 1:ncol(d321_ratios))
   {
        i = 12
        d321_filtered = d321_ratios[d321_ratios[,i] < 10, ]
        plot(d321_filtered[,i], col="red", type="l")
        lines(d210_ratios[,i], col="black")
        
#         m321 = mean(d321_ratios[,i])
#         m210 = mean(d210_ratios[,i])
#         
#         print(c(m321, m210))
#         
#         (m321 - m210)/m210
    }
}

prepareMetrics2<-function(base_workspace, path1, path2, tlb_file)
{

    h210_means = array(0, 24)
    h321_means = array(0, 24)

    d210_tlb = read.csv(paste(path1, tlb_file, sep="/"));
    d321_tlb = read.csv(paste(path2, tlb_file, sep="/"));
    d210_ratios = 1000 * d210_tlb/d210_tlb[,'c000']
    d321_ratios = 1000 * d321_tlb/d321_tlb[,'c000']

   for(i in 4:ncol(d321_ratios))
   {
        col321 = d321_ratios[,i]
        col321_no_outliers = col321[!col321 %in% boxplot.stats(col321)$out]
        
        col210 = d210_ratios[,i]
        col210_no_outliers = col210[!col210 %in% boxplot.stats(col210)$out]
        
        pngfile=paste(substr(tlb_file, 1, nchar(tlb_file) - 4), "_", colnames(d321_ratios)[i], ".png", sep="")
        saveAsPNG2(pngfile, col210_no_outliers, col321_no_outliers, main = colnames(d321_ratios)[i], xlab="Time", ylab="Value/1000 inst", legendT=c("2.10.0", "3.2.1"))
        
        h210_means[i] = mean(col210_no_outliers, na.rm=T) #, na.rm=T)[4 : ncol(d210_ratios)]
        h321_means[i] = mean(col321_no_outliers, na.rm=T) #colMeans(col_no_outliers, na.rm=T)[4 : ncol(d321_ratios)]
    }

    return(list("h210" = h210_means, "h321" = h321_means))
}

base_workspace="~/Ananth/Research/research_code/results_workspace/bdb/host/bdb_basic_set4-8_repeat/"
setwd(base_workspace)

bdb_perf_files=c(
"cc_run.csv", 
"fft0_5_run.csv", 
"grep_run.csv", 
"matmult0_5_run.csv", 
"md5_run.csv", 
"randsample_run.csv", 
"sort_run.csv", 
"wc_run.csv"
)

bdb_tlb_files=c(
"cc_run_tlb.csv", 
"fft0_5_run_tlb.csv", 
"grep_run_tlb.csv", 
"matmult0_5_run_tlb.csv", 
"md5_run_tlb.csv", 
"randsample_run_tlb.csv", 
"sort_run_tlb.csv", 
"wc_run_tlb.csv"
)

paths<- hash()
path1 = "2.10.0/small" 
path2 = "3.2.1/small"

h321 <- matrix(0, 8, 24)
h210 <- matrix(0, 8, 24)
f=1
for(f in 1:length(bdb_tlb_files))
{
    if(f ==7 ) 
    {
        next
    }
    r = prepareMetrics2(base_workspace, path1, path2, bdb_tlb_files[f])
    h321[f,] = round(r[["h321"]],2)
    h210[f,] = round(r[["h210"]],2)
}
