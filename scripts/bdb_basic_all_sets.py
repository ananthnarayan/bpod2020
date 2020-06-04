import os

file22 = open("run22.csv", "w+")
file22.write("Workload,Timestamp,CPU,Mem,Set\n")
file23 = open("run23.csv", "w+")
file23.write("Workload,Timestamp,CPU,Mem,Set\n")
file33 = open("run33.csv", "w+")
file33.write("Workload,Timestamp,CPU,Mem,Set\n")


for subdir, dirs, files in os.walk("../data/bdb_basic_all_sets_may25"):
    for file in files:
        filepath = subdir + os.sep + file
        
        if(".pidstat" in filepath):

            if("2.10.0_2.10.0" in filepath):
                datafile = open(filepath, "r+")
                flag = 0
                for line in datafile.readlines():
                    
                    if("%CPU" in line):
                        flag = 1
                        continue
                    if(flag == 1):
                        data = line.split()
                        flag = 0
                        if(len(data) != 0):


                            if("set1" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set1\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')


                            if("set2" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set2\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')

                            if("set3" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set3\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')

                            if("set4" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set4\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')

                            if("set5" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set5\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')

                            if("set6" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set6\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')

                            if("set7" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set7\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')

                            if("set8" in filepath):
                                if("sort_prep" in filepath):
                                    file22.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("sort_run" in filepath):
                                    file22.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("wc_prep" in filepath):
                                    file22.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("wc_run" in filepath):
                                    file22.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("randsample_prep" in filepath):
                                    file22.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("randsample_run" in filepath):
                                    file22.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("matmult0_5_prep" in filepath):
                                    file22.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("matmult0_5_run" in filepath):
                                    file22.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("md5_prep" in filepath):
                                    file22.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("md5_run" in filepath):
                                    file22.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("grep_prep" in filepath):
                                    file22.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("grep_run" in filepath):
                                    file22.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("fft0_5_run" in filepath):
                                    file22.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("fft0_5_prep" in filepath):
                                    file22.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')  
                                if("cc_prep" in filepath):
                                    file22.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set8\n")
                                if("cc_run" in filepath):
                                    file22.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                            
                datafile.close()
                

            if("2.10.0_3.2.1" in filepath):
                datafile = open(filepath, "r+")
                flag = 0
                for line in datafile.readlines():
                    
                    if("%CPU" in line):
                        flag = 1
                        continue
                    if(flag == 1):
                        data = line.split()
                        flag = 0
                        if(len(data) != 0):


                            if("set1" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set1\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')


                            if("set2" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set2\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')

                            if("set3" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set3\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')

                            if("set4" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set4\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')

                            if("set5" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set5\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')

                            if("set6" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set6\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')

                            if("set7" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set7\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')

                            if("set8" in filepath):
                                if("sort_prep" in filepath):
                                    file23.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("sort_run" in filepath):
                                    file23.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("wc_prep" in filepath):
                                    file23.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("wc_run" in filepath):
                                    file23.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("randsample_prep" in filepath):
                                    file23.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("randsample_run" in filepath):
                                    file23.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("matmult0_5_prep" in filepath):
                                    file23.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("matmult0_5_run" in filepath):
                                    file23.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("md5_prep" in filepath):
                                    file23.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("md5_run" in filepath):
                                    file23.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("grep_prep" in filepath):
                                    file23.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("grep_run" in filepath):
                                    file23.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("fft0_5_run" in filepath):
                                    file23.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("fft0_5_prep" in filepath):
                                    file23.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')  
                                if("cc_prep" in filepath):
                                    file23.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set8\n")
                                if("cc_run" in filepath):
                                    file23.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                            
                datafile.close()

            if("3.2.1_3.2.1" in filepath):
                datafile = open(filepath, "r+")
                flag = 0
                for line in datafile.readlines():
                    
                    if("%CPU" in line):
                        flag = 1
                        continue
                    if(flag == 1):
                        data = line.split()
                        flag = 0
                        if(len(data) != 0):


                            if("set1" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set1\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set1\n')


                            if("set2" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set2\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set2\n')

                            if("set3" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set3\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set3\n')

                            if("set4" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set4\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set4\n')

                            if("set5" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set5\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set5\n')

                            if("set6" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set6\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set6\n')

                            if("set7" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set7\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set7\n')

                            if("set8" in filepath):
                                if("sort_prep" in filepath):
                                    file33.write("sort_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("sort_run" in filepath):
                                    file33.write("sort_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("wc_prep" in filepath):
                                    file33.write("wc_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("wc_run" in filepath):
                                    file33.write("wc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("randsample_prep" in filepath):
                                    file33.write("randsample_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("randsample_run" in filepath):
                                    file33.write("randsample_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("matmult0_5_prep" in filepath):
                                    file33.write("matmult0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("matmult0_5_run" in filepath):
                                    file33.write("matmult0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("md5_prep" in filepath):
                                    file33.write("md5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("md5_run" in filepath):
                                    file33.write("md5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("grep_prep" in filepath):
                                    file33.write("grep_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("grep_run" in filepath):
                                    file33.write("grep_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("fft0_5_run" in filepath):
                                    file33.write("fft0_5_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                                if("fft0_5_prep" in filepath):
                                    file33.write("fft0_5_prep," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')  
                                if("cc_prep" in filepath):
                                    file33.write("cc_prep," + data[0] + "," + data[6] + ',' + data[12] + ",set8\n")
                                if("cc_run" in filepath):
                                    file33.write("cc_run," + data[0] + "," + data[6] + ',' + data[12] + ',set8\n')
                            
                datafile.close()