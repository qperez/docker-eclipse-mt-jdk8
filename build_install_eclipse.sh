#!/bin/bash
URL_ECLIPSE=$1

#Bash script workaround for the different behaviors of ADD : https://github.com/moby/moby/issues/4391
#Check if tar.gz is already present and decompressed in tmp
ls -l
if [ -d "eclipse" ]; then
  echo "eclipse directory already present, move to /opt"
  mv eclipse /opt
else
  echo "eclipse directory not present, extraction and installation of : ${URL_ECLIPSE##*/}"
  tar -xf ${URL_ECLIPSE##*/} -C /opt && \
  rm ${URL_ECLIPSE##*/}
fi
