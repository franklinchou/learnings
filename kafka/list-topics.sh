# List all topics

parallel-ssh -i -h hosts -x "-i ~/.ssh/PeerTestKafka.pem" "sudo /usr/local/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --list"
