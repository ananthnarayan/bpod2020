# Sort Run - Set 1

set1 = data['Set'] == 'set1'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[set1 & grep_run]
grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set1_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set1_Mem")

# Sort Run - Set 2

dataset = data['Set'] == 'set2'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set2_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set2_Mem")

# Sort Run - set3

dataset = data['Set'] == 'set3'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set3_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set3_Mem")

# Sort Run - set4

dataset = data['Set'] == 'set4'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set4_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set4_Mem")

# Sort Run - set5

dataset = data['Set'] == 'set5'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set5_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set5_Mem")

# Sort Run - set6

dataset = data['Set'] == 'set6'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set6_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set6_Mem")

# Sort Run - set7

dataset = data['Set'] == 'set7'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set7_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set7_Mem")

# Sort Run - set8

dataset = data['Set'] == 'set8'
grep_run = data['Workload'] == 'grep_run'
grep_run = data[dataset & grep_run]

grep_run.plot(x = 'Timestamp', y='CPU', title = "grep_run_set8_CPU")
grep_run.plot(x = 'Timestamp', y='Mem', title = "grep_run_set8_Mem")