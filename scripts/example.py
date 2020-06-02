# Sort Run - Set 1

set1 = data['Set'] == 'set1'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[set1 & matmult0_5_run]
matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set1_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set1_Mem")

# Sort Run - Set 2

dataset = data['Set'] == 'set2'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set2_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set2_Mem")

# Sort Run - set3

dataset = data['Set'] == 'set3'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set3_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set3_Mem")

# Sort Run - set4

dataset = data['Set'] == 'set4'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set4_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set4_Mem")

# Sort Run - set5

dataset = data['Set'] == 'set5'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set5_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set5_Mem")

# Sort Run - set6

dataset = data['Set'] == 'set6'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set6_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set6_Mem")

# Sort Run - set7

dataset = data['Set'] == 'set7'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set7_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set7_Mem")

# Sort Run - set8

dataset = data['Set'] == 'set8'
matmult0_5_run = data['Workload'] == 'matmult0_5_run'
matmult0_5_run = data[dataset & matmult0_5_run]

matmult0_5_run.plot(x = 'Timestamp', y='CPU', title = "matmult0_5_run_set8_CPU")
matmult0_5_run.plot(x = 'Timestamp', y='Mem', title = "matmult0_5_run_set8_Mem")