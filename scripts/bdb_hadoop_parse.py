import os

file22 = open("hadooprun22.csv", "w+")
file22.write("Workload,Service,RSS,Mem,Set\n")
file23 = open("hadooprun23.csv", "w+")
file23.write("Workload,Service,RSS,Mem,Set\n")
file33 = open("hadooprun33.csv", "w+")
file33.write("Workload,Service,RSS,Mem,Set\n")


for subdir, dirs, files in os.walk("hadoop-data"):
    for file in files:
        filepath = subdir + os.sep + file
        
        if(".pidstat" in filepath):
            if("2.10.0-2.10.0" in filepath):
                datafile = open(filepath, "r+")
                flag = 0
                for line in datafile.readlines():
                    
                    if("Time" not in line):
                        data = line.split()
                        if(len(data) > 7):
                            if("sort_prep" in filepath):
                                file22.write("sort_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("sort_run" in filepath):
                                file22.write("sort_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("wc_prep" in filepath):
                                file22.write("wc_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("wc_run" in filepath):
                                file22.write("wc_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("randsample_prep" in filepath):
                                file22.write("randsample_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("randsample_run" in filepath):
                                file22.write("randsample_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("matmult0_5_prep" in filepath):
                                file22.write("matmult0_5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("matmult0_5_run" in filepath):
                                file22.write("matmult0_5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("md5_prep" in filepath):
                                file22.write("md5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("md5_run" in filepath):
                                file22.write("md5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("grep_prep" in filepath):
                                file22.write("grep_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("grep_run" in filepath):
                                file22.write("grep_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("fft0_5_run" in filepath):
                                file22.write("fft0_5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("fft0_5_prep" in filepath):
                                file22.write("fft0_5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')  
                            if("cc_prep" in filepath):
                                file22.write("cc_prep," + data[2] + "," + data[6] + ',' + data[7] + ",set1\n")
                            if("cc_run" in filepath):
                                file22.write("cc_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                datafile.close()
                

            if("2.10.0-3.2.1" in filepath):
                datafile = open(filepath, "r+")
                flag = 0
                for line in datafile.readlines():
                    
                    if("Time" not in line):
                        data = line.split()
                        if(len(data) > 7):
                            if("sort_prep" in filepath):
                                file23.write("sort_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("sort_run" in filepath):
                                file23.write("sort_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("wc_prep" in filepath):
                                file23.write("wc_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("wc_run" in filepath):
                                file23.write("wc_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("randsample_prep" in filepath):
                                file23.write("randsample_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("randsample_run" in filepath):
                                file23.write("randsample_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("matmult0_5_prep" in filepath):
                                file23.write("matmult0_5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("matmult0_5_run" in filepath):
                                file23.write("matmult0_5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("md5_prep" in filepath):
                                file23.write("md5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("md5_run" in filepath):
                                file23.write("md5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("grep_prep" in filepath):
                                file23.write("grep_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("grep_run" in filepath):
                                file23.write("grep_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("fft0_5_run" in filepath):
                                file23.write("fft0_5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("fft0_5_prep" in filepath):
                                file23.write("fft0_5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')  
                            if("cc_prep" in filepath):
                                file23.write("cc_prep," + data[2] + "," + data[6] + ',' + data[7] + ",set1\n")
                            if("cc_run" in filepath):
                                file23.write("cc_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')

                datafile.close()

            if("3.2.1-3.2.1" in filepath):
                datafile = open(filepath, "r+")
                flag = 0
                for line in datafile.readlines():
                    
                    if("Time" not in line):
                        data = line.split()
                        if(len(data) > 7):
                            if("sort_prep" in filepath):
                                file33.write("sort_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("sort_run" in filepath):
                                file33.write("sort_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("wc_prep" in filepath):
                                file33.write("wc_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("wc_run" in filepath):
                                file33.write("wc_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("randsample_prep" in filepath):
                                file33.write("randsample_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("randsample_run" in filepath):
                                file33.write("randsample_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("matmult0_5_prep" in filepath):
                                file33.write("matmult0_5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("matmult0_5_run" in filepath):
                                file33.write("matmult0_5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("md5_prep" in filepath):
                                file33.write("md5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("md5_run" in filepath):
                                file33.write("md5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("grep_prep" in filepath):
                                file33.write("grep_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("grep_run" in filepath):
                                file33.write("grep_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("fft0_5_run" in filepath):
                                file33.write("fft0_5_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')
                            if("fft0_5_prep" in filepath):
                                file33.write("fft0_5_prep," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')  
                            if("cc_prep" in filepath):
                                file33.write("cc_prep," + data[2] + "," + data[6] + ',' + data[7] + ",set1\n")
                            if("cc_run" in filepath):
                                file33.write("cc_run," + data[2] + "," + data[6] + ',' + data[7] + ',set1\n')

                datafile.close()