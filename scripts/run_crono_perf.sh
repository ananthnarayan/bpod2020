CRONOBASE=/home/ananth/CRONO
export CRONOBASE=$CRONOBASE
CRONOAPPBASE=$CRONOBASE/apps
export CRONOAPPBASE=$CRONOAPPBASE

NUMTHREADS=32
delay=500
#perf stat -e r00c0 -e r02c0 -e r01c2 -e r0108 -e r010e -e r0185 ./apsp 3 500 499
#
#perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r02C0 -e r4f2e -e r412e -e r003C -e r01C2 -e r0108 -e r0185 -I $delay -x ',' -o apsp.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 40000 96

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
#02c0 : FP instructions
#4f2e : llc references
#2e41 : llc misses
#003c : cycles
#01C2 : uops retired- all (Broadwell)
#0108 : DTLB misses
#0185 : itlb miss

perf_command="perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r02C0 -e r4f2e -e r412e -e r003C -e r01C2 -e r0108 -e r0185 -I $delay -x ','"

eval "$perf_command  -o apsp.perf $CRONOAPPBASE/apsp/apsp $NUMTHREADS 40000 96"

eval "$perf_command -o bc.perf $CRONOAPPBASE/bc/bc $NUMTHREADS 60000 64"

eval "$perf_command -o bfs.perf $CRONOAPPBASE/bfs/bfs 0 $NUMTHREADS 640000 50"

eval "$perf_command -o community.perf $CRONOAPPBASE/community/community_lock 0 $NUMTHREADS I 6448644 100"

eval "$perf_command -o connected.perf $CRONOAPPBASE/connected_components/connected_components_lock 0 $NUMTHREADS 6448644 200"

eval "$perf_command -o pagerank.perf $CRONOAPPBASE/pagerank/pagerank 0 $NUMTHREADS 500000 2000"

eval "$perf_command -o sssp.perf $CRONOAPPBASE/sssp/sssp 0 $NUMTHREADS 400000 200"

eval "$perf_command -o triangle.perf $CRONOAPPBASE/triangle_counting/triangle_counting_lock 0 $NUMTHREADS 500000 10000"

eval "$perf_command -o tsp.perf $CRONOAPPBASE/tsp/tsp $NUMTHREADS 26"

echo  "The end"
