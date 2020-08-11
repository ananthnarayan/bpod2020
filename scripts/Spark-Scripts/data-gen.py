import os
import sys
import lorem
import random

'''
tiny = 1GB
small = 5GB
large = 10GB
'''

size = sys.argv[1]

sort_file = open("sort-" + size, "w")
grep_file = open("grep-" + size, "w")
wc_file = open("wc-" + size, "w")
cc_file = open("cc-" + size, "w")
pagerank_file = open("pr-" + size, "w")
als_file = open("als-" + size, "w")

if(size == "tiny"):
    total_bytes = 1e9
elif(size == "small"):
    total_bytes = 5e9
else:
    total_bytes=1e10


while(os.stat(sort_file).st_size < total_bytes):
    sort_file.write(lorem.sentence() + "\n")

while(os.stat(grep_file).st_size < total_bytes):
    grep_file.write(lorem.sentence() + "\n")

while(os.stat(wc_file).st_size < total_bytes):
    wc_file.write(lorem.sentence() + "\n")

while(os.stat(cc_file).st_size < total_bytes):
    cc_file.write(str(random.randint(0, 100)) + " " + str(random.randint(0, 100)) + "\n")

while(os.stat(als_file).st_size < total_bytes):
    als_file.write(str(random.randint(0, 100)) + "," + str(random.randint(0, 100)) + "," + str(random.randint(0, 5)) + "\n")

sort_file.close()
grep_file.close()
wc_file.close()
cc_file.close()
pagerank_file.close()
als_file.close()