##
## Author : Ananth Narayan S
##

#declare -a events;
#00C0 : instructions
#C4, C5 : branch inst, branch mispredicts
#4f2e : llc references
#412e : llc misses
#003c : cycles


#events=('00C0' '00C4' '00c5' '4f2e' '412e' '003c' 'intel_cqm/llc_occupancy/' 'intel_cqm/total_bytes/' 'intel_cqm/local_bytes/' )
events_set1=('00C0' '00C4' '00c5' '4f2e' '412e' '003c' 'intel_cqm/llc_occupancy/' 'intel_cqm/total_bytes/' 'intel_cqm/local_bytes/' )
events_set2=('3f24' 'ef24' '0151' '0480' 'context-switches' 'page-faults')
events_set3=('81d0' '82d0')

declare -A eventNames

eventNames['003c']='cycles'
eventNames['00C0']='instructions'
eventNames['00C4']='branch_instructions'
eventNames['00c5']='branch_mispredicts'
eventNames['0151']='l1d_replacement'
eventNames['0480']='icache_ifdatastall' #do not use preferably
eventNames['3f24']='l2_miss' #do not use preferably
eventNames['412e']='llc_misses'
eventNames['4f2e']='llc_references'
eventNames['81d0']='mem_loads'
eventNames['82d0']='mem_stores'
eventNames['context-switches']='context_switches'
eventNames['ef24']='l2_references' #do not use preferably
eventNames['intel_cqm.llc_occupancy']='cache_occupancy'
eventNames['intel_cqm.local_bytes']='local_bytes'
eventNames['intel_cqm.total_bytes']='total_bytes'
eventNames['page-faults']='page_faults'

parse_events_one_set()
{
    declare -a events=()
    
    if [ $# -eq 0 ];
    then
        echo "Missing arguments to function"
        exit
    fi
    which_events=$1
    case "$which_events" in
        "set1")
        for ii in ${!events_set1[@]}; do
            events[$ii]=${events_set1[$ii]}
        done
        ;;
        "set2")
        for ii in ${!events_set2[@]}; do
            events[$ii]=${events_set2[$ii]}
        done
        ;;
        "set3")
        for ii in ${!events_set3[@]}; do
            events[$ii]=${events_set3[$ii]}
        done
        ;;
    esac
   
    eventsCount=${#events[@]}
    tempFile="event_temp.perf"
    file=$2

    #There is a 'unit' header for some metrics such as cpu-clock.
    #If any event is not supported then mark it with a -1. This has to 
    #be ignored or handled as null/invalid data in subsequent processing.
    #Extract only the first 5 fields.
    cat $file | tr -s " " | sed "s/<not supported>/-1/g" | sed "s/<not counted>/-1/g" | cut -d "," -f 1-5 > $tempFile 
    ## Extract each event from the perf output and save it into separate files. 
    for((j=0;j<$eventsCount;j++))
    do
        event=${events[$j]}
        eventn=`echo $event | sed 's/\//\./g'`
        if [[ "$eventn" == *\. ]]; then
                eventn=${eventn::-1}
        fi
        echo -e "\t Extracting $event from $file"
        echo -e "${eventNames[$eventn]}" > $eventn.txt
        grep -i "$event" $tempFile  |  cut -d "," -f 2 >> $eventn.txt
        #mv $final_out $intermediate_csv
        #paste -d "," $intermediate_csv $eventn.txt > $final_out
    done

    echo "Done with $which_events"
}

#intermediate_csv="intermediate.csv"
#final_out="final_out.csv" 

parse_events_for_workload()
{
    #parse events for this one
    file_base=$1
    
    parse_events_one_set "set1" "set1/"$file_base"_set1.perf"
    sleep 1
    parse_events_one_set "set2" "set2/"$file_base"_set2.perf"
    sleep 1
    parse_events_one_set "set3" "set3/"$file_base"_set3.perf"
    sleep 1 
    
    txtFiles=(`ls *.txt | sort`)
    txtFilesCount=${#txtFiles[@]}
    
    echo "$txtFilesCount text files created. Merging to create single csv..."

    cat ${txtFiles[0]} > intermediate.csv
    
    for((jj=0;jj<$txtFilesCount;jj++))
    do
        paste -d "," intermediate.csv ${txtFiles[$jj]} > tmp.csv 
        mv tmp.csv intermediate.csv
    done
    mv intermediate.csv ${file_base}.csv
    #echo "" > ${file_base}.csv
    #cat intermediate.csv >> ${file_base}.csv
    #rm intermediate.csv
    echo "Done"
}

cd set1
files=(`ls *.perf`)
cd ..
echo "AAA"
filesCount=${#files[@]}
echo -e "Total files to parse: $filesCount"

for((i=0;i<$filesCount;i++))
do
    file=${files[$i]}
    file_base=${file::-10}
    echo "File base is: $file_base, i=$i"
    parse_events_for_workload  $file_base
done
