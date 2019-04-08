# Restart zookeeper on the kafka clusters then restart kafka

parallel-ssh -i -h hosts -x "-i ~/.ssh/PeerTestKafka.pem" "sudo service kafka stop; sudo /usr/local/kafka/bin/zookeeper-server-stop.sh; sleep 20; sudo /usr/local/kafka/bin/zookeeper-server-start.sh -daemon /etc/kafka/config/zookeeper.properties; sudo service kafka start"
