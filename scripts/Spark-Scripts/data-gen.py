import os
import sys
import lorem
import random

'''
tiny = 1GB
small = 5GB
large = 10GB
'''

size = str(sys.argv[1])

sort_file = open("sort-" + size + ".txt", "w")
grep_file = open("grep-" + size + ".txt", "w")
wc_file = open("wc-" + size + ".txt", "w")
cc_file = open("cc-" + size + ".txt", "w")
pagerank_file = open("pr-" + size + ".txt", "w")
als_file = open("als-" + size + ".txt", "w")

if(size == "tiny"):
    total_bytes = 1e3
elif(size == "small"):
    total_bytes = 5e9
else:
    total_bytes=1e10


while(os.stat(str("sort-" + size + ".txt")).st_size < total_bytes):
    sort_file.write(lorem.sentence() + "\n")
print("Sort done")

while(os.stat(str("grep-" + size + ".txt")).st_size < total_bytes):
    grep_file.write(lorem.sentence() + "\n")
print("Grep done")

while(os.stat(str("wc-" + size + ".txt")).st_size < total_bytes):
    wc_file.write(lorem.sentence() + "\n")
print("WC done")

while(os.stat(str("cc-" + size + ".txt")).st_size < total_bytes):
    cc_file.write(str(random.randint(0, 100)) + " " + str(random.randint(0, 100)) + "\n")
print("CC done")

while(os.stat(str("als-" + size + ".txt")).st_size < total_bytes):
    als_file.write(str(random.randint(0, 100)) + "," + str(random.randint(0, 100)) + "," + str(random.randint(0, 5)) + "\n")
print("ALS done")

while(os.stat(str("pr-" + size + ".txt")).st_size < total_bytes):
    pagerank_file.write(str(random.randint(0, 100)) + " " + str(random.randint(0, 100)) + "\n")
print("PageRank done")

sort_file.close()
grep_file.close()
wc_file.close()
cc_file.close()
pagerank_file.close()
als_file.close()