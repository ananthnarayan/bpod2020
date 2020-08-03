##
## Author : Ananth Narayan S
##

#events_set1=('00C0' '00C4' '00c5' '4f2e' '412e' '003c' 'intel_cqm/llc_occupancy/' 'intel_cqm/total_bytes/' 'intel_cqm/local_bytes/' )
#events_set2=('3f24' 'ef24' '0151' '0480' 'context-switches' 'page-faults')
#events_set3=('81d0' '82d0')

events_set1=('00C0' '00C4' '00c5' '4f2e' '412e' '003c' 'intel_cqm/llc_occupancy/' 'intel_cqm/total_bytes/' 'intel_cqm/local_bytes/' 'ff88')
events_set2=('2124' '4124' '5024' '3024' 'ff89' 'context-switches' 'page-faults')
events_set3=('81d0' '82d0' '0151' '0480')
events_set4=('003c' '00c0' '0108' '0208' '1008' '2008')
events_set5=('0149' '0249' '1049' '2049')
events_set6=('014f' '01ae' '0185' '0285')
events_set7=('1085' '2085' '11bc' '21bc')
events_set8=('12bc' '22bc' '14bc' '24bc' '18bc')

declare -A eventNames
eventNames['003c']='3c00' #cycles
eventNames['00C0']='C000' #instructions
eventNames['00C4']='C400' #branch_instructions
eventNames['00c5']='c500' #branch_mispredicts
eventNames['412e']='llc_misses'
eventNames['4f2e']='llc_references'
eventNames['81d0']='mem_loads'
eventNames['82d0']='mem_stores'
eventNames['2124']='2421'
eventNames['4124']='2441'
eventNames['5024']='2450'
eventNames['3024']='2430'
eventNames['ff89']='89ff'
eventNames['8002']='0280'
eventNames['0151']='5101'
eventNames['0480']='8004'
eventNames['0108']='0801'
eventNames['ff88']='88ff'

eventNames['context-switches']='context_switches'
eventNames['intel_cqm.llc_occupancy']='cache_occupancy'
eventNames['intel_cqm.local_bytes']='local_bytes'
eventNames['intel_cqm.total_bytes']='total_bytes'
eventNames['page-faults']='page_faults'

eventNames['0208']='0802'
eventNames['1008']='0810'
eventNames['2008']='0820'
eventNames['0149']='4901'
eventNames['0249']='4902' #
eventNames['1049']='4910' #
eventNames['2049']='4920'
eventNames['014f']='4f01'
eventNames['01ae']='ae01'
eventNames['0185']='8501'
eventNames['0285']='8502'
eventNames['1085']='8510' #
eventNames['2085']='8520'
eventNames['11bc']='bc11'
eventNames['21bc']='bc21'
eventNames['12bc']='bc12'
eventNames['22bc']='bc22'
eventNames['14bc']='bc14'
eventNames['24bc']='bc24'
eventNames['18bc']='bc18'

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
        "set4")
        for ii in ${!events_set4[@]}; do
            events[$ii]=${events_set4[$ii]}
        done
        ;;
        "set5")
        for ii in ${!events_set5[@]}; do
            events[$ii]=${events_set5[$ii]}
        done
        ;;
        "set6")
        for ii in ${!events_set6[@]}; do
            events[$ii]=${events_set6[$ii]}
        done
        ;;
        "set7")
        for ii in ${!events_set7[@]}; do
            events[$ii]=${events_set7[$ii]}
        done
        ;;
        "set8")
        for ii in ${!events_set8[@]}; do
            events[$ii]=${events_set8[$ii]}
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
    parse_events_one_set "set4" "set4/"$file_base"_set4.perf"
    sleep 1
    parse_events_one_set "set5" "set5/"$file_base"_set5.perf"
    sleep 1
    parse_events_one_set "set6" "set6/"$file_base"_set6.perf"
    sleep 1 
    parse_events_one_set "set7" "set7/"$file_base"_set7.perf"
    sleep 1 
    parse_events_one_set "set8" "set8/"$file_base"_set8.perf"
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
    mv intermediate.csv ${file_base}_tlb.csv
    #echo "" > ${file_base}.csv
    #cat intermediate.csv >> ${file_base}.csv
    #rm intermediate.csv
    echo "Done"
}

cd set1
files=(`ls *.perf`)
cd ..

filesCount=${#files[@]}
echo -e "Total files to parse: $filesCount"

for((i=0;i<$filesCount;i++))
do
    file=${files[$i]}
    file_base=${file::-10}

    echo "File base is: $file_base, i=$i"
    parse_events_for_workload  $file_base
done
