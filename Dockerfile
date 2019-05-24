FROM openjdk:8-alpine

# install basic tools
RUN apk --update add wget tar bash
# download and install Spark 
RUN wget http://mirror.nohup.it/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
RUN tar -xzf spark-2.4.3-bin-hadoop2.7.tgz && \
    mv spark-2.4.3-bin-hadoop2.7 /spark && \
    rm spark-2.4.3-bin-hadoop2.7.tgz

# start nodes scripts
COPY start-master.sh /start-master.sh
COPY start-worker.sh /start-worker.sh

# web UI
EXPOSE 8080
# master 
EXPOSE 7077
