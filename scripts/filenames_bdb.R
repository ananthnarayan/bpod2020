
library('hash');

bdb_210_small_perf_files=c(
"cc_run.csv", 
"fft0_5_run.csv", 
"grep_run.csv", 
"matmult0_5_run.csv", 
"md5_run.csv", 
"randsample_run.csv", 
#"sort_run.csv", 
"wc_run.csv"
)


bdb_210_small_sar_files=c(
"set1/sar_cc_run.csv", 
"set1/sar_fft0_5_run.csv", 
"set1/sar_grep_run.csv", 
"set1/sar_matmult0_5_run.csv", 
"set1/sar_md5_run.csv", 
"set1/sar_randsample_run.csv", 
#"set1/sar_sort_run.csv", 
"set1/sar_wc_run.csv"
)

bdb_210_small_virt_files=c(
"set1/virt_cc_run.csv", 
"set1/virt_fft0_5_run.csv", 
"set1/virt_grep_run.csv", 
"set1/virt_matmult0_5_run.csv", 
"set1/virt_md5_run.csv", 
"set1/virt_randsample_run.csv", 
#"set1/virt_sort_run.csv", 
"set1/virt_wc_run.csv"
)


paths<- hash()
#guest
#paths['bdb_210_small'] = "bdb/guest/2.10.0/small" 
#paths['bdb_321_small'] = "bdb/guest/3.2.1/small"
#host 
#meena@localhost:~/Ananth/Research/research_code/results_workspace/bdb/host/3.2.1/small 
paths['bdb_210_small'] = "bdb/host/2.10.0/small" 
paths['bdb_321_small'] = "bdb/host/3.2.1/small"

fileslist<-hash()
fileslist["bdb_210_small"]  = bdb_210_small_perf_files
fileslist["bdb_210_small_sar"]  = bdb_210_small_sar_files

bdb_321_small_perf_files = bdb_210_small_perf_files #the file names are the same. 
bdb_321_small_sar_files  = bdb_210_small_sar_files

fileslist["bdb_321_small"]  = bdb_321_small_perf_files
fileslist["bdb_321_small_sar"]  = bdb_321_small_sar_files


metrics_bdb_210_small_perf_files  =  paste("metrics", bdb_210_small_perf_files,  sep="_")
metrics_bdb_321_small_perf_files  =  paste("metrics", bdb_321_small_perf_files,  sep="_")

metrics_filelist <-hash() #sar doesn't have extra metrics
metrics_filelist["bdb_210_small"]  = metrics_bdb_210_small_perf_files
metrics_filelist["bdb_321_small"]  = metrics_bdb_321_small_perf_files

