
workload_data=read.csv("~/Ananth/research/results_workspace/workload_data.csv", sep=";")
#Trim to what we want.
workload_data = workload_data[c(2:15)]
cpi <- workload_data["cycles"]/workload_data["instructions"]
llc_load_miss <- workload_data["LLC.load.misses"]/workload_data["instructions"]
llc_load <- workload_data["LLC.loads"]/workload_data["instructions"]
branch_miss <- workload_data["branch.misses"]/workload_data["instructions"]
metrics <- data.frame(cpi, llc_load_miss, llc_load, branch_miss)
the_clusters = kmeans(metrics, 4, iter.max=10, nstart=1, algorithm="Lloyd")

plot(cpi[,1], type="p", character=".")

plot(the_clusters$cluster)
plot(the_clusters[["centers"]])
