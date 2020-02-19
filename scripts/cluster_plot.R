
workload_data=read.csv("~/Ananth/research/results_workspace/workload_data1.csv", sep=";")
#Trim to what data we want.
workload_data = workload_data[c(2:14)]
cpi <- workload_data["cycles"]/workload_data["instructions"]
llc_load_miss <- workload_data["LLC.load.misses"]/workload_data["instructions"]
llc_load <- workload_data["LLC.loads"]/workload_data["instructions"]
branch_miss <- workload_data["branch.misses"]/workload_data["instructions"]
metrics <- data.frame(cpi, llc_load_miss, llc_load, branch_miss)
the_clusters = kmeans(metrics, 4, iter.max=10, nstart=1, algorithm="Lloyd")

plot(cpi[,1], type="l")
plot(llc_load_miss[,1], type="l")
plot(llc_load[,1], type="l")
plot(branch_miss[,1], type="l")
#
plot(the_clusters$cluster)
plot(the_clusters[["centers"]])
