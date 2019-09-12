# Kafka

Uses Kafka 2.12!

## Basics

Kafka = general purpose pub/sub messaging system

Publishers (or producers) send data to a topic (or stream) (topics are persisted to disk which can be retrieved with 
the help of zookeeper). The topic is listened to by consumers. A stream/topic can have many different consumers and each consumer can maintain its own state (its own position in the stream). Single consumer failure is a non-issue since non-failing consumers will rebalance to take over for a missing member.

Topics are managed by a kafka cluster (kafka Brokers form a kafka cluster; kafka brokers = kafka servers). 
Brokers receive messages from producers and store them to disk. Brokers also receive and respond to fetch requests from consumers
to retrieve messages from disk. 


## Scalability 

Both consumers and producers are scalable

Zookeeper manages the scalability of the Kafka cluster

## Checking on zookeeper

Check on the status of zookeeper in a broker on the cluster by ssh-ing onto the machine and issuing: 

```
sudo /usr/local/kafka/bin/zookeeper-shell.sh localhost:2181
```

At the zookeeper prompt issue:

- `ls /brokers/ids`
- `get /brokers/ids/<broker-id>`

If there is only a single broker-id, Kafka is not running as a cluster (each zookeeper instance only recognizes its own node).

## Restarting Kafka & zookeeper

Occasionally kafka (or zookeeper) will go down. (This will result in lost pods in Kubernetes or connection timeout errors.) 

1. Access the Kafka cluster using ssh (`ssh -i <aws-access-key> <host@ip>`). Since kafka runs on a cluster, its probably most effective to run the commands via `parallel-ssh`, see the included `restart-kafka.sh` script. Optionally check whether kafka is running by issuing (`sudo service kafka status`). Note: `<host>` is usually `ubuntu` on an AWS EC2 machine.
2. Access the binary files in `/usr/local/kafka/bin`
3. Check if zookeeper is running. (`/usr/local/kafka/bin/zookeeper-shell.sh localhost:2181`)
4. If zookeeper is not running, start zookeeper by issuing `sudo /usr/local/kafka/bin/zookeeper-server-start.sh -daemon /etc/kafka/config/zookeeper.properties` 
5. [test] If zookeeper is running, you should get a list of available topics when issuing `/usr/local/kafka/bin/kafka-topics.sh --bootstrap-server <SERVERS> --list` 
6. Start kafka (issue `sudo service kafka start`)

## Deleting logs

If disk space is over-utilized (`df`), delete logs contained in `/var/kafka`. This will delete all job history (which should be irrelevant if the cluster is not currently in the process of computing jobs). 

## Owning Kafka file system

Sometimes kafka will fail to start because kafka does not have access to log files in `/var/kafka`. The following command will assign all items in the file to the kafka user & kafka group.

```
chown -R kafka:kafka /var/kafka
```

## Listening for a topic on Kafka

```
./bin/kafka-console-consumer.sh --bootstrap-server <SERVERS> --topic <TOPIC>
```
