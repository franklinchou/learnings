# Kafka

## Basics

Streaming - publish data in real time to a cluster

How to get data from many data sources into cluster?

Kafka = general purpose pub/sub messaging system

Publishers (or producers) -> send data to stream called topic <- topic is listened to by consumers (topic is basically a feed name; a topic writes to a Log which is the topic's storage on disk)

Topics are managed by a kafka cluster (kafka Brokers form a kafka cluster)

A stream/topic can have many different consumers, each consumer can maintain its own state (its own position in the stream)

## Scalability 

Both consumers and producers are scalable

Zookeeper manages the scalability of the Kafka cluster

## Restarting Kafka & zookeeper

Occasionally kafka (or zookeeper) will go down. (This will result in lost pods in Kubernetes or connection timeout errors). 

1. Access the Kafka cluster using ssh (`ssh -i <aws-access> <ip>`). Since kafka runs on a cluster, its probably most effective to run the commands via `parallel-ssh`, see the included `restart-kafka.sh` script. Optionally check whether kafka is running by issuing (`sudo service kafka status`).
2. Access the binary files in `/usr/local/kafka/bin`
3. Check if zookeeper is running. (`/usr/local/kafka/bin/zookeeper-shell.sh localhost:2181`)
4. If zookeeper is not running, start zookeeper by issuing `sudo /usr/local/kafka/bin/zookeeper-server-start.sh -daemon /etc/kafka/config/zookeeper.properties` 
5. [test] `/usr/local/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --list` 
6. Start kafka (issue `sudo service kafka start`)

## Deleting logs

If disk space is over-utilized (`df`), delete logs contained in `/var/kafka`. This will delete all job history (which should be irrelevant if the cluster is not currently in the process of computing jobs).
