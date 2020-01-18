##
## Author : Ananth Narayan S
##
declare -a events;
events=( "cpu-clock" "context-switches" "cpu-migrations" "page-faults" "cycles" "instructions" "branches" "branch-misses" 
	 "L1-dcache-loads" "L1-dcache-load-misses" "LLC-loads" "LLC-loads-misses" "L1-icache-loads" "L1-icache-load-misses"
	 "dTLB-loads" "dTLB-loads-misses" "iTLB-loads" "iTLB-load-misses" "L1-dcache-prefetches" "L1-dcache-prefetch-misses") #List of events that we want to extract from the files
#This below set of events is where some the events that were marked as 'not supported' are removed from the above list.	 
#events=( "cpu-clock" "context-switches" "cpu-migrations" "page-faults" "cycles" "instructions" "branches" "branch-misses" 
#	 "L1-dcache-loads" "L1-dcache-load-misses" "LLC-loads" "LLC-loads-misses"  "L1-icache-load-misses"
#	 "dTLB-loads" "dTLB-loads-misses" "iTLB-loads" "iTLB-load-misses" ) #List of events that we want to extract from the files
	 
#list of input files, one for each benchmark that we run
perf_output_files=("events.perf") 
#list of output files, one for each benchmark that we run
final_output_files=("final_events.csv")
#Create the final output file. If one exists previously, delete it

tempfile="event_temp.perf"
intermediate_csv="intermediate.csv"
final_out="final_out.csv" 
rm $tempfile $intermediate_csv $final_out 
touch $final_out

#for file in "${perf_output_files[@]}"
count=${#perf_output_files[@]}
echo "Processing a total of $count files"
for ((i=0;i<$count;i++))
do
	file=${perf_output_files[$i]}
	cat $file | tr -s " " | sed "s/<not supported>/-1/g" | cut -d " " -f 1-4 > $tempfile 
## Extract each event from the perf output and
## save in separate files
	for event in "${events[@]}"
	do
		echo "Extracting $event from $tempfile"
		#header
		echo -e "$event" > $event.txt
		grep $event $tempfile  | tr -s " " | sed "s/<not supported/-1/g" |  cut -d " " -f 3 >> $event.txt
		mv $final_out $intermediate_csv
		paste -d ";" $intermediate_csv $event.txt > $final_out
	done
	mv final_out.csv ${final_output_files[$i]}

## Merge the separate files into one
## Merge has to be column-wise, with comma as separator
## giving us a nice csv
done

rm $intermediate_csv
rm $tempfile
rm $final_out

###
# It is best that we run perf with the -x. Else, perf
# does number formatting with commas which might cause trouble
# parsing. 
# perf stat -d -d -d -o events.txt  -I 1000 -x "\t"
# grep "cpu-clock" events.txt | tr -s "\t" | cut -d$'\t' -f 2
###
