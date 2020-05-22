echo "Starting set1"
bash bdb_pidstat.sh "set1" 1>bdb1.out 2>bdb1.err
sleep 60
echo "Starting set2"
bash bdb_pidstat.sh "set2" 1>bdb2.out 2>bdb2.err
sleep 60
echo "Starting set3"
bash bdb_pidstat.sh "set3" 1>bdb3.out 2>bdb3.err
sleep 60
echo "Starting set4"
bash bdb_pidstat.sh "set4" 1>bdb4.out 2>bdb4.err
sleep 60
echo "Starting set5"
bash bdb_pidstat.sh "set5" 1>bdb5.out 2>bdb5.err
sleep 60
echo "Starting set6"
bash bdb_pidstat.sh "set6" 1>bdb6.out 2>bdb6.err
sleep 60
echo "Starting set7"
bash bdb_pidstat.sh "set7" 1>bdb7.out 2>bdb7.err
sleep 60
echo "Starting set8"
bash bdb_pidstat.sh "set8" 1>bdb8.out 2>bdb8.err
sleep 60
