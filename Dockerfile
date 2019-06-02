FROM openjdk:8-alpine

ENV ALPINE_VERSION=3.9

# install basic tools
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_VERSION/community" >> /etc/apk/repositories
RUN apk --no-cache --update add wget \
                                tar \
                                bash \
                                python3 \
                                python3-dev \
                                openblas-dev \
#                                lapack-dev \
                                build-base

# download and install Spark 
RUN wget http://mirror.nohup.it/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
RUN tar -xzf spark-2.4.3-bin-hadoop2.7.tgz && \
    mv spark-2.4.3-bin-hadoop2.7 /spark && \
    rm spark-2.4.3-bin-hadoop2.7.tgz

# upgrade pip
RUN pip3 install --upgrade pip
COPY requirements.txt /requirements.txt
RUN pip3 install --upgrade -r /requirements.txt

# set environment vars
ENV SPARK_HOME=/spark
ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3

# start nodes scripts
COPY start-master.sh /start-master.sh
COPY start-worker.sh /start-worker.sh

# web UI
EXPOSE 8082
# master 
EXPOSE 7077
