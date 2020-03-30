library('hash')
#crono_files=c("apsp.csv","bc.csv","birch.csv","bfs.csv", "community.csv", "connected.csv", "tsp.csv", "pagerank.csv","sssp.csv","triangle.csv")

hibench_27_tiny_files=c(
"bayes_run.csv" , "sort_run.csv"      , 
"aggregation_run.csv"  ,  "kmeans_run.csv"   ,  "scan_run.csv"      ,  "wordcount_run.csv",
"join_run.csv"  , "pagerank_run.csv" , "sort_prep.csv"     , "terasort_run.csv"
)

hibench_27_small_files=c(
"bayes_run.csv" , "sort_run.csv"      , 
"aggregation_run.csv"  ,  "kmeans_run.csv"   ,  "scan_run.csv"      ,  "wordcount_run.csv",
"join_run.csv"  , "pagerank_run.csv" , "sort_prep.csv"     , "terasort_run.csv"
)

hibench_27_large_files=c(
"bayes_run.csv" , "sort_run.csv"      , 
"aggregation_run.csv"  ,  "kmeans_run.csv"   ,  "scan_run.csv"      ,  "wordcount_run.csv",
"join_run.csv"  , "pagerank_run.csv" , "sort_prep.csv"     , "terasort_run.csv"
)

hibench_210_tiny_files=c(
"bayes_run.csv" , "sort_run.csv"      , 
"aggregation_run.csv"  ,  "kmeans_run.csv"   ,  "scan_run.csv"      ,  "wordcount_run.csv",
"join_run.csv"  , "pagerank_run.csv" , "sort_prep.csv"     , "terasort_run.csv"
)

hibench_210_small_files=c(
"bayes_run.csv" , "sort_run.csv"      , 
"aggregation_run.csv"  ,  "kmeans_run.csv"   ,  "scan_run.csv"      ,  "wordcount_run.csv",
"join_run.csv"  , "pagerank_run.csv" , "sort_prep.csv"     , "terasort_run.csv"
)

hibench_210_large_files=c(
"bayes_run.csv" , "sort_run.csv"      , 
"aggregation_run.csv"  ,  "kmeans_run.csv"   ,  "scan_run.csv"      ,  "wordcount_run.csv",
"join_run.csv"  , "pagerank_run.csv" , "sort_prep.csv"     , "terasort_run.csv"
)

hibench_321_tiny_files=c(
"sort_run.csv"      , "wordcount_prep.csv", "terasort_prep.csv" , "wordcount_run.csv", "sort_prep.csv" , "terasort_run.csv"
)

hibench_321_small_files=c(
"sort_run.csv"      , "wordcount_prep.csv", "terasort_prep.csv" , "wordcount_run.csv", "sort_prep.csv" , "terasort_run.csv"
)

hibench_321_large_files=c(
"sort_run.csv"      , "wordcount_prep.csv", "terasort_prep.csv" , "wordcount_run.csv", "sort_prep.csv" , "terasort_run.csv"
)


paths<- hash()
#HiBench
paths["hibench_27_tiny"]="hadoop2.7/tiny"
paths["hibench_27_small"]="hadoop2.7/small"
paths["hibench_27_large"]="hadoop2.7/large"

paths["hibench_210_tiny"]="hadoop2.10/tiny"
paths["hibench_210_small"]="hadoop2.10/small"
paths["hibench_210_large"]="hadoop2.10/large"

paths["hibench_321_tiny"]="hadoop3.2.1/tiny"
paths["hibench_321_small"]="hadoop3.2.1/small"
paths["hibench_321_large"]="hadoop3.2.1/large"

#/home/meena/Ananth/Ananth-Research/research_code/results_workspace/bdb

fileslist<-hash()
fileslist["hibench_27_tiny"]  = hibench_27_tiny_files
fileslist["hibench_27_small"] = hibench_27_small_files
fileslist["hibench_27_large"] = hibench_27_large_files

fileslist["hibench_210_tiny"]  = hibench_210_tiny_files
fileslist["hibench_210_small"] = hibench_210_small_files
fileslist["hibench_210_large"] = hibench_210_large_files

fileslist["hibench_321_tiny"]  = hibench_321_tiny_files
fileslist["hibench_321_small"] = hibench_321_small_files
fileslist["hibench_321_large"] = hibench_321_large_files


metrics_hibench_27_tiny_filelist  =  paste("metrics", hibench_27_tiny_files,  sep="_")
metrics_hibench_27_small_filelist =  paste("metrics", hibench_27_small_files, sep="_")
metrics_hibench_27_large_filelist =  paste("metrics", hibench_27_large_files, sep="_") 

metrics_hibench_210_tiny_filelist  =  paste("metrics", hibench_210_tiny_files,  sep="_")
metrics_hibench_210_small_filelist =  paste("metrics", hibench_210_small_files, sep="_")
metrics_hibench_210_large_filelist =  paste("metrics", hibench_210_large_files, sep="_") 


metrics_hibench_321_tiny_filelist  =  paste("metrics", hibench_321_tiny_files,  sep="_")
metrics_hibench_321_small_filelist =  paste("metrics", hibench_321_small_files, sep="_")
metrics_hibench_321_large_filelist =  paste("metrics", hibench_321_large_files, sep="_") 


metrics_filelist <-hash()
metrics_filelist["hibench_27_tiny"]  = metrics_hibench_27_tiny_filelist
metrics_filelist["hibench_27_small"] = metrics_hibench_27_small_filelist
metrics_filelist["hibench_27_large"] = metrics_hibench_27_large_filelist

metrics_filelist["hibench_210_tiny"]  = metrics_hibench_210_tiny_filelist
metrics_filelist["hibench_210_small"] = metrics_hibench_210_small_filelist
metrics_filelist["hibench_210_large"] = metrics_hibench_210_large_filelist

metrics_filelist["hibench_321_tiny"]  = metrics_hibench_321_tiny_filelist
metrics_filelist["hibench_321_small"] = metrics_hibench_321_small_filelist
metrics_filelist["hibench_321_large"] = metrics_hibench_321_large_filelist
