# Restart zookeeper on the kafka clusters then restart kafka

# hosts is a text file containing the ip addresses of all the kafka nodes in the cluster
# replace PeerTestKafka.pem with the appropriate key
parallel-ssh -i -h hosts -x "-i ~/.ssh/PeerTestKafka.pem" "sudo service kafka stop; sudo /usr/local/kafka/bin/zookeeper-server-stop.sh; sleep 20; sudo /usr/local/kafka/bin/zookeeper-server-start.sh -daemon /etc/kafka/config/zookeeper.properties; sudo service kafka start"
