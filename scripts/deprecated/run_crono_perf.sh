CRONOBASE=/home/ananth/CRONO
export CRONOBASE=$CRONOBASE
CRONOAPPBASE=$CRONOBASE/apps
export CRONOAPPBASE=$CRONOAPPBASE

NUMTHREADS=32
delay=500

#$CRONOAPPBASE/bc/bc $NUMTHREADS 60000 64 

#$CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 640000 50 

#$CRONOAPPBASE/community/community_lock 0 $NUMTHREADS I 6448644 100 

#$CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 6448644 200 

#$CRONOAPPBASE/dfs/dfs $NUMTHREADS $CRONOAPPBASE/dfs/sample.txt 

#$CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 500000 2000 

#$CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 400000 200 

#$CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 500000 10000 

#$CRONOAPPBASE/tsp/tsp $NUMTHREADS 26


#00C0 : instructions
#00c4 : branch instructions
#00c5 : Mispredicted branch instructions
#4f2e : llc references
#2e41 : llc misses
#003c : cycles
#0108 : DTLB misses
#0185 : itlb miss

perf_command="perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -I $delay -x ','"

eval "$perf_command  -o apsp_tiny.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 12000 2"
eval "$perf_command  -o apsp_small.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 30000 80"
eval "$perf_command  -o apsp_large.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 60000 9000"

eval "$perf_command -o bc_tiny.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 1000 2"
eval "$perf_command -o bc_small.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 3000 500"
eval "$perf_command -o bc_large.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 6000 5900"

eval "$perf_command -o bfs_tiny.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 10000 2"
eval "$perf_command -o bfs_small.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 8000 800"
eval "$perf_command -o bfs_large.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 90000 9000"

eval "$perf_command -o community_tiny.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS 40 100 20"
eval "$perf_command -o community_small.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS 50 5000 4000"
eval "$perf_command -o community_large.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS 50 10000 999"

eval "$perf_command -o connected_tiny.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 1000 200"
eval "$perf_command -o connected_small.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 10000 900"
eval "$perf_command -o connected_large.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 50000 1000"

eval "$perf_command -o pagerank_tiny.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 10000 5000"
eval "$perf_command -o pagerank_small.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 50000 8000"
eval "$perf_command -o pagerank_large.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 100000 9000"

eval "$perf_command -o sssp_tiny.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 1000 400"
eval "$perf_command -o sssp_small.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 5000 800"
eval "$perf_command -o sssp_large.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 100000 9000"

eval "$perf_command -o triangle_tiny.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 1000 800"
eval "$perf_command -o triangle_small.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 5000 2000"
eval "$perf_command -o triangle_large.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 100000 9000" 

eval "$perf_command -o tsp_tiny.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 10"
eval "$perf_command -o tsp_small.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 25"
eval "$perf_command -o tsp_large.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 30"

echo  "The end"
