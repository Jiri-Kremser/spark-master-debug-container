FROM java:8u111-jdk-alpine

RUN mkdir /tmp/spark && \
    chmod ug+rw /etc/passwd &&\
    
    apk --update --no-cache add bash && \
    rm -rf /var/cache/apk/* && \
    echo '/tmp/spark/bin/spark-submit --class org.apache.spark.examples.SparkPi --master spark://c:7077 --executor-memory 1G /tmp/spark/bin/examples.jar 10' | tee /test > ~/.bash_history

# note: when adding additional stuff, don't forget to whitelist it in the .dockerignore
ADD ./bin /tmp/spark/bin
ADD ./assembly/target/scala-*/jars /tmp/spark/jars
ADD ./examples/target/scala-*/jars/spark-examples_*.jar /tmp/spark/bin/examples.jar
ADD ./conf /tmp/spark/conf
ADD ./entrypoint.sh /entrypoint.sh

WORKDIR /tmp/spark/bin

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
