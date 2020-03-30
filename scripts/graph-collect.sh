# Author: Ishaan L

cd

cd CRONO/apps

rm -r /home/ananth/Results

mkdir /home/ananth/Results

apsp/make
{ time ./apsp/apsp 32 12000 2; }  2> ~/Results/apsp.txt
wait
{ time ./apsp/apsp 32 30000 800; } 2> ~/Results/apsp.txt
wait
{ time ./apsp/apsp 32 60000 9000; } 2> ~/Results/apsp.txt
wait

bc/make
{ time ./bc/bc 32 1000 2; } 2> ~/Results/bc.txt
wait
{ time ./bc/bc 32 3000 500; } 2> ~/Results/bc.txt
wait
{ time ./bc/bc 32 6000 5900; } 2> ~/Results/bc.txt
wait

bfs/make
{ time ./bfs/bfs 0 32 1000 2; } 2> ~/Results/bfs.txt
wait
{ time ./apsp/apsp 32 8000 800; } 2> ~/Results/bfs.txt
wait
{ time ./bfs/bfs 0 32 90000 9000; } 2> ~/Results/bfs.txt
wait

community/make
{ time ./community/community_lock 0 32 1000 40 20; } 2> ~/Results/comm.txt
wait
{ time ./community/community_lock 0 32 5000 50 4000; } 2> ~/Results/comm.txt
wait
{ time ./community/community_lock 0 32 10000 50 9999 ; } 2> ~/Results/comm.txt
wait

connected_components/make
{ time ./connected_components/connected_components_lock 0 32 1000 200; } 2> ~/Results/conn.txt
wait
{ time ./connected_components/connected_components_lock 0 32 10000 900; } 2> ~/Results/conn.txt
wait
{ time ./connected_components/connected_components_lock 0 32 50000 1000; } 2> ~/Results/conn.txt
wait


dfs/make
{ time ./dfs/dfs 0 10000 32; } 2> ~/Results/dfs.txt
wait
{ time ./dfs/dfs 0 500000 32; } 2> ~/Results/dfs.txt
wait
{ time ./dfs/dfs 0 1000000 32; } 2> ~/Results/dfs.txt
wait


pagerank/make
{ time ./pagerank/pagerank 0 32 10000 5000; } 2> ~/Results/pagerank.txt
wait
{ time ./pagerank/pagerank 0 32 50000 8000; } 2> ~/Results/pagerank.txt
wait
{ time ./pagerank/pagerank 0 32 100000 9000; } 2> ~/Results/pagerank.txt
wait


sssp/make
{ time ./sssp/sssp 0 32 10000 4000; } 2> ~/Results/sssp.txt
wait
{ time ./sssp/sssp 0 32 50000 8000; } 2> ~/Results/sssp.txt
wait
{ time ./sssp/sssp 0 32 100000 9000; } 2> ~/Results/sssp.txt
wait

triangle_counting/make
{ time ./triangle_counting/triangle_counting_lock 0 32 1000 800; } 2> ~/Results/triangle_counting.txt
wait
{ time ./triangle_counting/triangle_counting_lock 0 32 5000 2000; } 2> ~/Results/triangle_counting.txt
wait
{ time ./triangle_counting/triangle_counting_lock 0 32 100000 9999; } 2> ~/Results/triangle_counting.txt
wait


tsp/make
{ time ./tsp/tsp 32 10; } 2> ~/Results/tsp.txt
wait
{ time ./tsp/tsp 32 40; } 2> ~/Results/tsp.txt
wait
{ time ./tsp/tsp 32 50; } 2> ~/Results/tsp.txt
