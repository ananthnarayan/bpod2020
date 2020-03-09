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
#1eca : fp assists
#4f2e : llc references
#2e41 : llc misses
#003c : cycles
#0108 : DTLB misses
#0185 : itlb miss

perf_command="perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5 -e r1eca -e r4f2e -e r412e -e r003C -e r0108 -e r0185 -I $delay -x ','"

eval "$perf_command  -o apsp_small.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 120 2"
eval "$perf_command  -o apsp_med.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 600 80"
eval "$perf_command  -o apsp_big.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 10000 9999"

eval "$perf_command -o bc_small.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 100 2"
eval "$perf_command -o bc_med.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 500 100"
eval "$perf_command -o bc_big.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 10000 9999"

eval "$perf_command -o bfs_small.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 1000 2"
eval "$perf_command -o bfs_med.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 50000 1000"
eval "$perf_command -o bfs_big.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 100000 99999"

eval "$perf_command -o community_small.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS 40 100 20"
eval "$perf_command -o community_med.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS 120 1000 300"
eval "$perf_command -o community_big.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS 1000 10000 1000"

eval "$perf_command -o connected_small.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 100 20"
eval "$perf_command -o connected_med.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 1000 300"
eval "$perf_command -o connected_big.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 10000 3000"

eval "$perf_command -o pagerank_small.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 100 20"
eval "$perf_command -o pagerank_med.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 1000 400"
eval "$perf_command -o pagerank_big.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 10000 4000"

eval "$perf_command -o sssp_small.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 100 10"
eval "$perf_command -o sssp_med.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 1000 600"
eval "$perf_command -o sssp_big.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 10000 5000"

eval "$perf_command -o triangle_small.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 100 20"
eval "$perf_command -o triangle_med.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 1000 300"
eval "$perf_command -o triangle_big.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 10000 1300" 

eval "$perf_command -o tsp_small.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 25"
eval "$perf_command -o tsp_med.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 70"
eval "$perf_command -o tsp_big.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 100"

echo  "The end"
