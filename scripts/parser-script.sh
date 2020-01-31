##
## Author : Ananth Narayan S
##
declare -a events;
#events=( "cpu-clock" "context-switches" "cpu-migrations" "page-faults" "cycles" "instructions" "branches" "branch-misses" 
#	 "L1-dcache-loads" "L1-dcache-load-misses" "LLC-loads" "LLC-load-misses" "L1-icache-loads" "L1-icache-load-misses"
#	 "dTLB-loads" "dTLB-load-misses" "iTLB-loads" "iTLB-load-misses" "L1-dcache-prefetches" "L1-dcache-prefetch-misses") #List of events that we want to extract from the files
events=( "cycles" "instructions" "branches" "branch-misses" 
	 "L1-dcache-loads" "L1-dcache-load-misses" "LLC-loads" "LLC-load-misses" "L1-icache-loads" "L1-icache-load-misses"
	 "dTLB-loads" "dTLB-load-misses" "iTLB-loads" "iTLB-load-misses" "L1-dcache-prefetches" "L1-dcache-prefetch-misses") #List of events that we want to extract from the files

# This below set of events is where some the events that were marked as 'not supported' are removed from the above list.	 
#events=( "cpu-clock" "context-switches" "cpu-migrations" "page-faults" "cycles" "instructions" "branches" "branch-misses" 
#	 "L1-dcache-loads" "L1-dcache-load-misses" "LLC-loads" "LLC-loads-misses"  "L1-icache-load-misses"
#	 "dTLB-loads" "dTLB-loads-misses" "iTLB-loads" "iTLB-load-misses" ) #List of events that we want to extract from the files
	 
# List of input files, one for each benchmark that we run
# Assume that all files are present in the same directory
#perf_output_files=("events.perf") 
if [ $# -eq 0 ];
then
	echo "Missing command line arguments"
	exit
fi
perf_output_files=("$@")
#list of output files, one for each benchmark that we run
#Create the final output file. If one exists previously, delete it

tempfile="event_temp.perf"
intermediate_csv="intermediate.csv"
final_out="final_out.csv" 
#rm $tempfile $intermediate_csv $final_out 

rm *.txt

count=${#perf_output_files[@]}
echo "Processing a total of $count files"
for ((i=0;i<$count;i++))
do
	touch $final_out
	touch $intermediate_csv
	file=${perf_output_files[$i]}
	final_output_file=`basename $file .data`
	final_output_file=${final_output_file}.csv
	echo "Writing to $final_output_file"
	#there is a 'unit' header for some metrics such as cpu-clock.
	#so we need 5 columns. This adds the # rows where unit is not
	#applicable. Better way would be to use sed and replace the unit
	#with a tab, but for that we need a list of all units
	cat $file | tr -s " " | sed "s/<not supported>/-1/g" | cut -d ";" -f 1-5 > $tempfile 
## Extract each event from the perf output and
## save in separate files
	for event in "${events[@]}"
	do
		echo "Extracting $event from $tempfile"
		# Print a header
		echo -e "$event" > $event.txt
		grep ";$event" $tempfile  |  cut -d ";" -f 2 >> $event.txt
		mv $final_out $intermediate_csv
		paste -d ";" $intermediate_csv $event.txt > $final_out
	done
	echo "final_out.csv -> ${final_output_file}"
	mv final_out.csv ${final_output_file}
	sync
	sleep 1
	rm $intermediate_csv
	rm $tempfile
## Merge the separate files into one
## Merge has to be column-wise, with comma as separator
## giving us a nice csv
done
echo "Done"
#rm $intermediate_csv
#rm $tempfile

###
# It is best that we run perf with the -x. Else, perf
# does number formatting with commas which might cause trouble
# parsing. 
# perf stat -d -d -d -o events.txt  -I 1000 -x "\t"
# grep "cpu-clock" events.txt | tr -s "\t" | cut -d$'\t' -f 2
###
