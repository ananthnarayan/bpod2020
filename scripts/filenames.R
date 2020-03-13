library('hash')
#crono_files=c("apsp.csv","bc.csv","birch.csv","bfs.csv", "community.csv", "connected.csv", "tsp.csv", "pagerank.csv","sssp.csv","triangle.csv")

minebench_files=c("bayes.csv","hop.csv","kmeans_edge.csv","rsearch.csv","svm.csv" ,"eclat.csv","kmeans_color.csv")
hibench_tiny_files=c(
"aggregation_prep.csv" , "bayes_run.csv" , "kmeans_prep.csv"        , "nutchindexing_run.csv" , "scan_prep.csv" , "sort_run.csv"      , "wordcount_prep.csv",
"aggregation_run.csv"  , "join_prep.csv" , "kmeans_run.csv"         , "pagerank_prep.csv"     , "scan_run.csv"  , "terasort_prep.csv" , "wordcount_run.csv",
"bayes_prep.csv"       , "join_run.csv"  , "nutchindexing_prep.csv" , "pagerank_run.csv"      , "sort_prep.csv" , "terasort_run.csv"
)

hibench_small_files=c(
"aggregation_prep.csv" , "bayes_run.csv" , "kmeans_prep.csv"        , "nutchindexing_run.csv" , "scan_prep.csv" , "sort_run.csv"      , "wordcount_prep.csv",
"aggregation_run.csv"  , "join_prep.csv" , "kmeans_run.csv"         , "pagerank_prep.csv"     , "scan_run.csv"  , "terasort_prep.csv" , "wordcount_run.csv",
"bayes_prep.csv"       , "join_run.csv"  , "nutchindexing_prep.csv" , "pagerank_run.csv"      , "sort_prep.csv" , "terasort_run.csv"
)

hibench_large_files=c(
"aggregation_prep.csv" , "bayes_run.csv" , "kmeans_prep.csv"        , "scan_prep.csv" , "sort_run.csv"      , "wordcount_prep.csv",
"aggregation_run.csv"  , "join_prep.csv" , "kmeans_run.csv"         , "scan_run.csv"  , "terasort_prep.csv" , "wordcount_run.csv",
"bayes_prep.csv"       , "join_run.csv"  , "sort_prep.csv" , "terasort_run.csv"
)

crono_dense_files=c("pagerank.csv")
crono_sparse_files=c("pagerank.csv")


mlperf_files=c()
bdb_files=c()

paths<- hash()
#HiBench
paths["hibench_tiny"]="HiBench/32GB/tiny"
paths["hibench_small"]="HiBench/32GB/small"
paths["hibench_large"]="HiBench/32GB/large"
#paths["crono"]="crono_mb_19feb2020/"
paths["crono_sparse"] = "crono_pagerank/sparse"
paths["crono_dense"]="crono_pagerank/dense"

fileslist<-hash()
fileslist["hibench_tiny"]  = hibench_tiny_files
fileslist["hibench_small"] = hibench_small_files
fileslist["hibench_large"] = hibench_large_files
fileslist["crono_sparse"]  = crono_sparse_files
fileslist["crono_dense"]   = crono_dense_files

metrics_hibench_tiny_filelist  =  paste("metrics", hibench_tiny_files,  sep="_")
metrics_hibench_small_filelist =  paste("metrics", hibench_small_files, sep="_")
metrics_hibench_large_filelist =  paste("metrics", hibench_large_files, sep="_") 
metrics_crono_sparse_filelist  =  paste("metrics", crono_sparse_files,  sep="_")
metrics_crono_dense_filelist   =  paste("metrics", crono_dense_files,   sep="_")

metrics_filelist <-hash()
metrics_filelist["hibench_tiny"]  = metrics_hibench_tiny_filelist
metrics_filelist["hibench_small"] = metrics_hibench_small_filelist
metrics_filelist["hibench_large"] = metrics_hibench_large_filelist
metrics_filelist["crono_sparse"]  = metrics_crono_sparse_filelist
metrics_filelist["crono_dense"]   = metrics_crono_dense_filelist
