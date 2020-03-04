# Author: Ishaan L

apsp/make
perf stat -d -d -d --output ~/Results/apsp-small.data -x ';' -I 1000 ./apsp/apsp 2 100000 2 > apsp.txt
perf stat -d -d -d --output ~/Results/apsp-big.data -x ';' -I 1000 ./apsp/apsp 2 100000 99999 > apsp.txt

bc/make
perf stat -d -d -d --output ~/Results/bc-small.data -x ';' -I 1000 ./bc/bc 2 100000 2 > bc.txt
perf stat -d -d -d --output ~/Results/bc-big.data -x ';' -I 1000 ./bc/bc 2 100000 99999 > bc.txt

bfs/make
perf stat -d -d -d --output ~/Results/bfs-small.data -x ';' -I 1000 ./bfs/bfs 0 2 100000 2 > bfs.txt
perf stat -d -d -d --output ~/Results/bfs-big.data -x ';' -I 1000 ./bfs/bfs 0 2 100000 99999 > bfs.txt

community/make
perf stat -d -d -d --output ~/Results/community-small.data -x ';' -I 1000 ./community/community_lock 0 2 100 100000 2 > community_lock.txt
perf stat -d -d -d --output ~/Results/community-big.data -x ';' -I 1000 ./community/community_lock 0 2 100 100000 99999 > community_lock.txt

connected_components/make
perf stat -d -d -d --output ~/Results/connected_components-small.data -x ';' -I 1000 ./connected_components/connected_components_lock 0 2 100000 2 > connected_components_lock.txt
perf stat -d -d -d --output ~/Results/connected_components-big.data -x ';' -I 1000 ./connected_components/connected_components_lock 0 2 100000 99999 > connected_components_lock.txt


dfs/make
perf stat -d -d -d --output ~/Results/dfs-small.data -x ';' -I 1000 ./dfs/dfs 0 100000 2 > dfs.txt
perf stat -d -d -d --output ~/Results/dfs-big.data -x ';' -I 1000 ./dfs/dfs 0 100000 99999 > dfs.txt


pagerank/make
perf stat -d -d -d --output ~/Results/pagerank-small.data -x ';' -I 1000 ./pagerank/pagerank 0 2 100000 2 > pagerank.txt
perf stat -d -d -d --output ~/Results/pagerank-big.data -x ';' -I 1000 ./pagerank/pagerank 0 2 100000 99999 > pagerank.txt


sssp/make
perf stat -d -d -d --output ~/Results/sssp-small.data -x ';' -I 1000 ./sssp/sssp 0 2 100000 2 > sssp.txt
perf stat -d -d -d --output ~/Results/sssp-big.data -x ';' -I 1000 ./sssp/sssp 0 2 100000 99999 > sssp.txt


triangle_counting/make
perf stat -d -d -d --output ~/Results/triangle_counting-small.data -x ';' -I 1000 ./triangle_counting/triangle_counting_lock 0 2 100000 2 > triangle_counting.txt
perf stat -d -d -d --output ~/Results/triangle_counting-big.data -x ';' -I 1000 ./triangle_counting/triangle_counting_lock 0 2 100000 99999 > triangle_counting.txt


tsp/make
perf stat -d -d -d --output ~/Results/tsp-small.data -x ';' -I 1000 ./tsp/tsp 2 100000 > tsp.txt
perf stat -d -d -d --output ~/Results/tsp-big.data -x ';' -I 1000 ./tsp/tsp 2 100000 > tsp.txt
