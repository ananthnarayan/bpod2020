# Author : Ishaan

rm -r ~/ishaan/MLResults

mkdir ~/ishaan/MLResults

cd 

cd mlperf/training

# sh install_cuda_docker.sh

# sh recommendation/download_dataset.sh

########################

# Reinforcement

cd ~/mlperf/training/reinforcement/tensorflow/
IMAGE=`sudo docker build . | tail -n 1 | awk '{print $3}'`
SEED=1
NOW=`date "+%F-%T"`
sudo docker run --runtime=nvidia -t -i $IMAGE "./run_and_time.sh" $SEED | tee benchmark-$NOW.log

########################

# RNN_Translator

cd ~/mlperf/training/rnn_translator/

sh download_dataset.sh

cd pytorch
sudo docker build . --rm -t gnmt:latest
SEED=1
NOW=`date "+%F-%T"`
sudo nvidia-docker run -it --rm --ipc=host \
  -v $(pwd)/../data:/data \
  gnmt:latest "./run_and_time.sh" $SEED |tee benchmark-$NOW.log

########################

# Sentiment

cd ~/mlperf/training/sentiment_analysis

docker pull sidgoyal78/paddle:benchmark12042018

nvidia-docker run -it -v `pwd`:/paddle sidgoyal78/paddle:benchmark12042018 /bin/bash

./download_dataset.sh
./verify_dataset.sh

cd paddle/
./run_and_time.sh <seed>

######################

