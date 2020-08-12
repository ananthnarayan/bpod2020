import pandas as pd
import scipy  as sp
from scipy.cluster.vq import vq, kmeans, whiten, kmeans2 
import numpy  as np
import os
import sys

if __name__ ==  "__main__":
    #open the file
    if len(sys.argv) < 2:
        print ("Insufficient command line args")
        exit()

    data_frame = pd.read_csv(sys.argv[1], sep=";")
    #print(data_frame)
    subset_df = data_frame[data_frame.columns[1:15]]
    #print(subset_df)
    data_as_matrix = subset_df.to_numpy()
    #print(data_as_matrix)
    normalized=whiten(data_as_matrix)
    (codebook, distortion) = kmeans(normalized, k_or_guess=4)
    print(codebook)
    print(distortion)
    print("########################")
    (centroids, label) = kmeans2(normalized, 4, minit="points")
    print(centroids)
    print(label)
    print("########################")
