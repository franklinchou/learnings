# Kafka

## Basics

Streaming - publish data in real time to a cluster

How to get data from many data sources into cluster?

Kafka = general purpose pub/sub messaging system

Publishers (or producers) -> send data to stream called topic <- topic is listened to by consumers (topic is basically a feed name; a topic writes to a Log which is the topic's storage on disk)

Topics are managed by a kafka cluster (kafka Brokers form a kafka cluster)

A stream/topic can have many different consumers, each consumer can maintain its own state (its own position in the stream)

# Scalability 

Both consumers and producers are scalable

Zookeeper manages the scalability of the Kafka cluster
