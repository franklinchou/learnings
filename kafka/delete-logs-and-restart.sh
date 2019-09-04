# Delete logs located in /var/kafka for a cluster of machines
# Then restart the kafka server

parallel-ssh -i -h hosts -x "-i ~/.ssh/PeerTestKafka.pem" \
  "for f in /var/kafka/*; do sudo rm -rf \"$f\"; done \
  sudo service kafka stop; \
  sudo /usr/local/kafka/bin/zookeeper-server-stop.sh; \
  sleep 20; \
  sudo /usr/local/kafka/bin/zookeeper-server-start.sh -daemon /etc/kafka/config/zookeeper.properties; \
  sudo service kafka start"
