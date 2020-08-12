#! /bin/bash

set_remote_spark_home() {
    HADOOP_HOME=/home/shaanzie/hadoop-$1
    SPARK_HOME=/home/shaanzie/spark-$2
    export SPARK_HOME=$SPARK_HOME
    export HADOOP_HOME=$HADOOP_HOME
    export PATH=$PATH:$SPARK_HOME/bin
    $HADOOP_HOME/sbin/stop-all.sh
    $SPARK_HOME/sbin/stop-all.sh
    $HADOOP_HOME/sbin/start-all.sh
    $SPARK_HOME/sbin/start-all.sh
}

prepare_input() {
    echo "$HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-input/$2 /$1"
    $HADOOP_HOME/bin/hdfs dfs -copyFromLocal ~/research-input/$2 /$1
}

cleanup_out() {
    $HADOOP_HOME/bin/hdfs dfs -rm -r /$1-out
    $HADOOP_HOME/bin/hdfs dfs -rm -r /$1
}

execute_workload() {
    bench=$1
    input=$2
    output=$3
    JAR_FILE=~/BigDataBench-Spark/target/scala-2.10/bigdatabench-spark_2.10-1.3.0.jar
    sar_delay=1
    sar_csv=sar_${bench}.csv
    pidstat_file=${bench}.pidstat
    
    sar_file=sar_out
    rm $sar_file

    delay=1000

    echo "===== $bench ======"

    sar -r ALL -u ALL -o $sar_file $sar_delay >/dev/null 2>&1 &
    sar_process=$!

    sync
    sleep 1

    case $bench in 

        "Grep")
            echo "Executing Grep"
            keyword=$4
            command="spark-submit --class cn.ac.ict.bigdatabench.$bench $JAR_FILE hdfs://localhost:9000/$input $keyword hdfs://localhost:9000/$output"
            ;;
        "PageRank")
            echo "Executing PageRank"
            iter=$4
            command="spark-submit --class cn.ac.ict.bigdatabench.$bench $JAR_FILE hdfs://localhost:9000/$input $iter hdfs://localhost:9000/$output"
            ;;
        "ALS")
            echo "Executing ALS"
            rank=$4
            iter=$5
            command="spark-submit --class cn.ac.ict.bigdatabench.$bench $JAR_FILE hdfs://localhost:9000/$input $rank $iter"
            ;;
        "ConnectedComponent")
            echo "Executing $bench"
            command="spark-submit --class cn.ac.ict.bigdatabench.$bench $JAR_FILE hdfs://localhost:9000/$input"
            ;;
        *)
            echo "Executing $bench"
            command="spark-submit --class cn.ac.ict.bigdatabench.$bench $JAR_FILE hdfs://localhost:9000/$input hdfs://localhost:9000/$output"
            ;;
    esac

    echo "Executing $command"
    eval $command

    timepid=$!
    bashpid=`ps -elf | grep "$command" | grep -v "/usr/bin/time" |  grep -v "grep" |   tr -s " " | cut -d " " -f 4`
    sleep 3
    javapid=`ps -elf | grep "$bashpid" | grep -v "grep" | tail -n 1 | tr -s " " | cut -d ' ' -f 4`
    namenode=`jps | grep -i -w  "NameNode" | cut -d " " -f 1`
    datanode=`jps | grep -i -w  "DataNode" | cut -d " " -f 1`
    nodeManager=`jps | grep -i -w  "NodeManager" | cut -d " " -f 1`
    resourcemanager=`jps | grep -i -w  "ResourceManager" | cut -d " " -f 1`
    secondarynamenode=`jps | grep -i -w  "SecondaryNameNode" | cut -d " " -f 1`
    master=`jps | grep -i -w  "Master" | cut -d " " -f 1`
    worker=`jps | grep -i -w  "Worker" | cut -d " " -f 1`

    echo -e "Bash: $bashpid Java: $javapid Hadoop: $namenode,$datanode,$nodeManager,$resourcemanager,$secondarynamenode,$master,$worker"
    pidstat -h -d -r -s -u -T ALL -p $javapid,$namenode,$datanode,$nodeManager,$resourcemanager,$secondarynamenode,$master,$worker $sar_delay > $pidstat_file &
    pidstat=$!

    echo "killing sar"
    kill -9 $sar_process
    sleep 1

    echo "killing pidstat"
    kill -9 $pidstat
    sleep 1

    sadf -dh $sar_file -- -r ALL -u ALL > $sar_csv

    sleep 5
}

hadoop="2.10.0"
spark="3.0.0"

set_remote_spark_home $hadoop $spark

size="tiny"

python3 data-gen.py $size
mv *.txt ~/research-input/

prepare_input "sort" "sort-$size.txt"
execute_workload "Sort" "sort" "sort-out"
cleanup_out "sort"

prepare_input "grep" "grep-$size.txt"
execute_workload "Grep" "grep" "grep-out" "sample"
cleanup_out "grep"

prepare_input "wc" "wc-$size.txt"
execute_workload "WordCount" "wc" "wc-out"
cleanup_out "wc"

prepare_input "cc" "cc-$size.txt"
execute_workload "ConnectedComponent" "cc" "cc-out"
cleanup_out "cc"

prepare_input "pr" "pr-$size.txt"
execute_workload "PageRank" "pr" "pr-out" 1
cleanup_out "pr"

prepare_input "als" "als-$size.txt"
execute_workload "ALS" "als" "als-out" 3 1
cleanup_out "als"

mkdir -p ~/SparkData/bdb/Hadoop:$hadoop-Spark:$spark/$size/
mv *.csv ~/SparkData/bdb/Hadoop:$hadoop-Spark:$spark/$size/
mv *.pidstat ~/SparkData/bdb/Hadoop:$hadoop-Spark:$spark/$size/
rm $sar_file
rm ~/research-input/*.txt