##
## Author : Ananth Narayan S
##
declare -a events;
declare -a eventNames;
declare -a eventNamesString;
#00C0 : instructions
#C4, C5 : branch inst, branch mispredicts
#4f2e : llc references
#412e : llc misses
#003c : cycles
#0108 : DTLB misses
#0185 : itlb miss
events=('00C0' '00C4' '00c5' '4f2e' '412e' '003c' 'intel_cqm/llc_occupancy/' 'intel_cqm/total_bytes/' 'intel_cqm/local_bytes/' )
'3f24', 'ef24' 0151 0480 'context-switches' 'page-faults' '81d0' '82d0'
eventNames=('Instructions' 'BranchInstructions' 'BranchMispredicts' 'LLCRef' 'LLCMiss' 'Cycles' 'LLCOcc' 'TotalBytes' 'LocalBytes')
#Turns out we didn't use this string at all. :) 
eventNamesString='Instructions,BranchInst,BranchMispredicts,LLCRef,LLCMiss,Cycles,DTLBMiss,ITLBMiss,LLCOcc,TotalBytes,LocalBytes'

# List of input files, one for each benchmark that we run
# Assume that all files are present in the same directory
if [ $# -eq 0 ];
then
	echo "Missing command line arguments"
	exit
fi
#list of output files, one for each benchmark that we run
perf_output_files=("$@")

#Create the final output file. If one exists previously, delete it
tempfile="event_temp.perf"
intermediate_csv="intermediate.csv"
final_out="final_out.csv" 

eventsCount=${#events[@]}

rm *.txt
#Get the number of files that we need to process. 
count=${#perf_output_files[@]}
echo "Processing a total of $count files"
for ((i=0;i<$count;i++))
do
	touch $final_out
	touch $intermediate_csv
	file=${perf_output_files[$i]}
	final_output_file=`basename $file .perf`
	final_output_file=${final_output_file}.csv
	echo "Writing to $final_output_file"
	#There is a 'unit' header for some metrics such as cpu-clock.
	#If any event is not supported then mark it with a -1. This has to 
	#be ignored or handled as null/invalid data in subsequent processing.
	cat $file | tr -s " " | sed "s/<not supported>/-1/g" | sed "s/<not counted>/-1/g" | cut -d "," -f 1-5 > $tempfile 
	## Extract each event from the perf output and save it into separate files. 
	for((j=0;j<$eventsCount;j++))
	do
		event=${events[$j]}
		eventn=`echo $event | sed 's/\//\./g'`
		if [[ "$eventn" == *\. ]]; then
                        eventn=${eventn::-1}
                fi
		echo -e "\tExtracting $event from $tempfile"
		echo -e "${eventNames[$j]}" > $eventn.txt
		grep -i "$event" $tempfile  |  cut -d "," -f 2 >> $eventn.txt
		mv $final_out $intermediate_csv
		paste -d "," $intermediate_csv $eventn.txt > $final_out
	done
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

###
# It is best that we run perf with the -x. Else, perf
# does number formatting with commas which might cause trouble
# parsing. 
# perf stat  -e blah -o events.txt  -I 1000 -x ","
###
