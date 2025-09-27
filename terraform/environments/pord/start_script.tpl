#!bin/bash

sudo apt update
sudo wget https://dlcdn.apache.org/jmeter/binaries/apache-jmeter-5.6.3.tgz
tar -xzvf apache-jmeter-5.6.3.tgz
sudo apt install openjdk-11-jre -y
sudo export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
sudo apache-jmeter-5.6.3/bin/jmeter -v
sudo echo 'server.rmi.ssl.disable=true' >> ./apache-jmeter-5.6.3/bin/jmeter.properties
sudo echo 'rmi.server.hostname=${server_host}' >> ./apache-jmeter-5.6.3/bin/jmeter.properties
sudo echo 'server_port=${rmi_port}' >> ./apache-jmeter-5.6.3/bin/jmeter.properties
sudo sed -i 's/set HEAP=-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m/set HEAP=-Xms20g -Xmx20g -XX:MaxMetaspaceSize=4096m/g' ./apache-jmeter-5.6.3/bin/jmeter.bat
# 以下はプラグインやCSVを読み込んで実行する際に利用します。GCSにファイルをアップロードしておくと各instanceにコピーされます。
# sudo gcloud storage cp gs://${pj_name}-stress-test-jmeter-csv/* ./
# sudo gcloud storage cp gs://${pj_name}-stress-test-jmeter-plugin-file/jmeter-plugins-cmn-jmeter-0.4.jar ./apache-jmeter-5.6.3/lib/
# sudo gcloud storage cp gs://${pj_name}-stress-test-jmeter-plugin-file/jmeter-plugins-manager-1.6.jar ./apache-jmeter-5.6.3/lib/ext/
# sudo gcloud storage cp gs://${pj_name}-stress-test-jmeter-plugin-file/jmeter-plugins-random-csv-data-set-0.8.jar ./apache-jmeter-5.6.3/lib/ext/
sudo echo 'export HEAP="-Xms30G -Xmx30G -XX:MaxMetaspaceSize=1G"' >> ./apache-jmeter-5.6.3/bin/setenv.sh
sudo ./apache-jmeter-5.6.3/bin/jmeter-server
