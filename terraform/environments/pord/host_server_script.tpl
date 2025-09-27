#!bin/bash

sudo apt update
sudo wget https://dlcdn.apache.org/jmeter/binaries/apache-jmeter-5.6.3.tgz
tar -xzvf apache-jmeter-5.6.3.tgz
sudo apt install openjdk-11-jre -y
sudo export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
sudo apache-jmeter-5.6.3/bin/jmeter -v
sudo echo 'server.rmi.ssl.disable=true' >> /apache-jmeter-5.6.3/bin/jmeter.properties
sudo sed -i 's/-XX:MaxMetaspaceSize=256m/-XX:MaxMetaspaceSize=4096m/g' /apache-jmeter-5.6.3/bin/jmeter
sudo sed -i 's/remote_hosts=127.0.0.1/remote_hosts=${remote_server_internal_ip_list}/g' /apache-jmeter-5.6.3/bin/jmeter.properties
sudo gcloud storage cp gs://${pj_name}-stress-test-jmeter-csv/* ./
sudo echo 'export HEAP="-Xms3G -Xmx3G -XX:MaxMetaspaceSize=296M"' >> ./apache-jmeter-5.6.3/bin/setenv.sh
sudo dd if=/dev/zero of=/swapfile bs=1M count=10000
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
