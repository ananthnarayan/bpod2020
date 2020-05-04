#!/bin/bash
##All purpose script for executing any bdb profiling
##
set_hadoop_home()
{
    HADOOP_HOME=/disk2/user/hadoops/hadoop-$1
}

cleanup_bdb () 
{
    $HADOOP_HOME/bin/hdfs dfs -rm -r /hadoop/$1
}
cleanup_bdb_cc ()
{
    $HADOOP_HOME/bin/hdfs dfs -rm -r /user/user/*
    $HADOOP_HOME/bin/hdfs dfs -rm -r /user/ananth/*
}
check_bdb_conf()
{
	echo ""
}

set_toplev_path() {
    export PATH=$PATH:/home/ananth/tools/pmu-tools
}
expunge () {
    $HADOOP_HOME/bin/hdfs dfs -expunge 
}

run_workload_toplev() {
    vmpid=$1
    bench=$2
    action=$3
    #1 second delay
    delay=1000
    
    sar_delay=1
    
    file=${bench}_${action}_$6.perf
    

    remote_command=$4
    time_log=$5
    
    #Clean up any old instances
    killall perf 
    
    echo "===== $bench : $action ======"
    set_path
    toplev.py -l3 -I 1000 -x, -o $file bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command    
    
    bench=$bench
    action=$action
    
    echo "Start sleep after $action"
    sleep 10

}

run_workload_sar_pidstat() {
    vmpid=$1
    bench=$2
    action=$3
    #1 second delay
    delay=1000
    
    sar_delay=1
    
    file=${bench}_${action}_$6.perf
    
    sar_file=sar_out
    rm $sar_file
     sar_csv=sar_${bench}_${action}.csv
    
    pidstat_file=${bench}_${action}.pidstat
    
    remote_command=$4
    time_log=$5
    
    #Clean up any old instances
    killall perf 
    killall sar 
    
    echo "===== $bench : $action ======"
    case $6 in
    "set1")
    	   perfcommand='perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C  -x "," -o $file -I $delay'
           sar -r ALL -B -W -o $sar_file $sar_delay > /dev/null 2>&1 & 
           sar_process=$!
	       ;;
    "set2")
            perfcommand='perf stat -e r3f24 -e ref24 -e r0151 -e r0480 -e context-switches -e page-faults  -x "," -o $file -I $delay'
            sar -b -u ALL -o $sar_file $sar_delay > /dev/null 2>&1 & 
            sar_process=$!
            ;;
    "set3")
          #perf stat -e cpu/event=0xa3,umask=10,cmask=16,name=Cycle_Activity.Cycles_Mem_Any/ -e cpu/event=0xa3,umask=14,cmask=20,name=Cycle_Activity.Stalls_MemAny/  -e r81d0 -e r82d0  -p $vmpid -x "," -o $file -I $delay &
            perfcommand='perf stat  -e r81d0 -e r82d0  -x "," -o $file -I $delay '
            sar -r ALL -B -W -o $sar_file $sar_delay > /dev/null 2>&1 & 
            sar_process=$!
            ;;
    esac
    sync #flush all buffers. 
    sleep 1
    command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout $perfcommand bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command  &"
    echo "Executing: $command"
    eval $command
    timepid=$!
    perfpid=`ps -elf | grep "$remote_command" | grep -v "/usr/bin/time" | grep -v "grep" | tr -s " " | cut -d " " -f 4`
    bashpid=`ps -elf | grep "$remote_command" | grep -v "/usr/bin/time" | grep -v "perf" | grep -v "grep" |   tr -s " " | cut -d " " -f 4`
    sleep 3
    javapid=`ps -elf | grep "$bashpid" | grep -v "grep" | tail -n 1 | tr -s " " | cut -d ' ' -f 4`
     
    echo -e "Perfpid: $perfpid Bash: $bashpid Java: $javapid"
    pidstat -h -r -s -T ALL -p $javapid $sar_delay > $pidstat_file &  
    time=`cat timeout` 
    wait $timepid
    echo "killing sar"
    kill -s SIGINT $sar_process
    #Pidstat would have terminated already. this is just for cleanup from our side. 
    echo "killing pidstat"
    kill -s SIGINT $pidstat 

    case $6 in
    	"set1")
	    sadf -dh $sar_file -- -r ALL -B -W > $sar_csv
	    ;;
	"set2")
		sadf -dh $sar_file -- -b -u  > $sar_csv
		;;
	"set3")
		sadf -dh $sar_file -- -r ALL -B -W > $sar_csv
		;;
    esac 
    
    bench=$bench
    action=$action
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}


run_workload_sar() {
    vmpid=$1
    bench=$2
    action=$3
    #1 second delay
    delay=1000
    
    sar_delay=1
    
    file=${bench}_${action}_$6.perf
    
    sar_file=sar_out
    rm $sar_file
     sar_csv=sar_${bench}_${action}.csv
    
    
    remote_command=$4
    time_log=$5
    
    #Clean up any old instances
    killall perf 
    killall sar 
    
    echo "===== $bench : $action ======"
    case $6 in
    "set1")
    	   perfcommand='perf stat -e intel_cqm/llc_occupancy/ -e intel_cqm/local_bytes/ -e intel_cqm/total_bytes/ -e r00C0 -e r00c4  -e r00c5  -e r4f2e -e r412e -e r003C  -x "," -o $file -I $delay'
           sar -r ALL -B -W -o $sar_file $sar_delay > /dev/null 2>&1 & 
           sar_process=$!
	       ;;
    "set2")
            perfcommand='perf stat -e r3f24 -e ref24 -e r0151 -e r0480 -e context-switches -e page-faults  -x "," -o $file -I $delay'
            sar -b -u ALL -o $sar_file $sar_delay > /dev/null 2>&1 & 
            sar_process=$!
            ;;
    "set3")
          #perf stat -e cpu/event=0xa3,umask=10,cmask=16,name=Cycle_Activity.Cycles_Mem_Any/ -e cpu/event=0xa3,umask=14,cmask=20,name=Cycle_Activity.Stalls_MemAny/  -e r81d0 -e r82d0  -p $vmpid -x "," -o $file -I $delay &
            perfcommand='perf stat  -e r81d0 -e r82d0  -x "," -o $file -I $delay '
            sar -r ALL -B -W -o $sar_file $sar_delay > /dev/null 2>&1 & 
            sar_process=$!
            ;;
    esac
    sync #flush all buffers. 
    sleep 1
    command="/usr/bin/time -f %e,%S,%U,%W,%c,%w -o timeout $perfcommand bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command "
    eval $command
    time=`cat timeout` 
    kill -s SIGINT $sar_process

    case $6 in
    	"set1")
	    sadf -dh $sar_file -- -r ALL -B -W > $sar_csv
	    ;;
	"set2")
		sadf -dh $sar_file -- -b -u  > $sar_csv
		;;
	"set3")
		sadf -dh $sar_file -- -r ALL -B -W > $sar_csv
		;;
    esac 
    
    bench=$bench
    action=$action
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}


run_workload_perfrec() {
    vmpid=$1
    bench=$2
    action=$3
    #1 second delay
    delay=1000
    
    sar_delay=1
    
    file=${bench}_${action}_$6.perf
    

    remote_command=$4
    time_log=$5
    
    #Clean up any old instances
    killall perf 
    
    echo "===== $bench : $action ======"
    set_path
    bash /disk2/user/BigDataBench_V5.0_BigData_MicroBenchmark/Hadoop/$remote_command    
    
    bench=$bench
    action=$action
    echo -e "$bench,$action,$time" >> $time_log
    
    echo "Start sleep after $action"
    sleep 10

}

run_workload(){
    profiling_type=$1
    case $profiling_type in
        "basic")
        run_workload_sar $@ 
        ;;
        "pidstat")
        run_workload_sar_pidstat $@
        ;;
        "toplev") 
        run_workload_toplev $@
        ;;
        "perfrecord")
        remote_command=$4
        new_remote_command=`echo $remote_command | sed 's/.sh/-prof.sh/'`
        echo "$new_remote_command"
        run_workload_perfrec $1 $2 $3 $new_remote_command $5 $6
        ;;
        *)
        echo "Unknown profiling type"
        exit
    esac
}



profile="small"
hadoop="2.10.0"
#hadoop="3.2.1"
set="set1"
profiling_type=$1
if [ $# -eq 0 ]; then
    echo "Missing args : profiling type";
    exit
fi

set_hadoop_home  $hadoop 
check_bdb_conf

case $profile in 
    "tiny")
        cc=8
        fft_dim=1024
        fft_sparsity=0.5
	    grep=1
        matmult_dim=100
        matmult_sparsity=0.5
        md5=1
        randsample=1
    ;;
    "small")
        cc=11
        fft_dim=2048
        fft_sparsity=0.5
	    grep=5
        matmult_dim=1000
        matmult_sparsity=0.5
        md5=5
        randsample=5
    ;;
    "large")
        cc=15
        fft_dim=4096
        fft_sparsity=0.5
	    grep=10
        matmult_dim=10000
        matmult_sparsity=0.5
        md5=10
        randsample=10
    ;;
    *)
        cc=8
        fft_dim=1024
        fft_sparsity=0.5
	    grep=1
        matmult_dim=100
        matmult_sparsity=0.5
        md5=1
        randsample=1
    ;;
esac 




date >> "timings.txt"
cleanup_bdb_cc
run_workload $profiling_type "cc" "prep" "CC/genData-cc.sh $cc" $time_log $set
run_workload $profiling_type "cc" "run" "CC/run-cc.sh $cc" $time_log $set
cleanup_bdb "cc"

run_workload $profiling_type "fft0_5" "prep" "FFT/genData-fft.sh $fft_dim $fft_dim $fft_sparsity" $time_log $set
run_workload $profiling_type "fft0_5" "run" "FFT/run-fft.sh $fft_dim $fft_dim $fft_sparsity" $time_log $set
cleanup_bdb "fft"

run_workload $profiling_type "grep" "prep" "Grep/genData-grep.sh $grep" $time_log $set
run_workload $profiling_type "grep" "run" "Grep/run-grep.sh $grep" $time_log $set
cleanup_bdb "grep"

run_workload $profiling_type "matmult0_5" "prep" "MatrixMult/genData-matMult.sh $matmult_sparsity $matmult_dim $matmult_dim $matmult_dim" $time_log $set
run_workload $profiling_type "matmult0_5" "run" "MatrixMult/run-matMult.sh $matmult_sparsity $matmult_dim $matmult_dim $matmult_dim" $time_log $set
cleanup_bdb "matMult"

run_workload $profiling_type "md5" "prep" "MD5/genData-md5.sh $md5" $time_log $set
run_workload $profiling_type "md5" "run" "MD5/run-md5.sh $md5" $time_log $set
cleanup_bdb "md5"
 
run_workload $profiling_type "randsample" "prep" "randSample/genData-randSample.sh $randsample" $time_log $set
run_workload $profiling_type "randsample" "run" "randSample/run-randSample.sh $randsample 0.5" $time_log $set
cleanup_bdb "randsample" 

run_workload $profiling_type "sort" "prep" "Sort/genData-sort.sh $grep" $time_log $set
run_workload $profiling_type "sort" "run" "Sort/run-terasort.sh $grep" $time_log $set
cleanup_bdb "terasort"

run_workload $profiling_type "wc" "prep" "wordcount/genData-wc.sh $grep" $time_log $set
run_workload $profiling_type "wc" "run" "wordcount/run-wordcount.sh $grep" $time_log $set
cleanup_bdb "wc"

expunge

mkdir -p bdb_${profiling_type}/$hadoop/$profile/$set
mv *.perf bdb_${profiling_type}/$hadoop/$profile/$set
mv $time_log bdb_${profiling_type}/$hadoop/$profile/$set
mv *.csv bdb_${profiling_type}/$hadoop/$profile/$set
mv *.pidstat bdb_${profiling_type}/$hadoop/$profile/$set
