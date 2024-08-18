#!/bin/bash
set -e

curl -fsSL https://dl.bintray.com/groovy/maven/apache-groovy-sdk/3.0.9/groovy-sdk-3.0.9.zip -o /tmp/groovy.zip
unzip /tmp/groovy.zip -d /usr/local
ln -s /usr/local/groovy-3.0.9/bin/groovy /usr/bin/groovy
rm /tmp/groovy.zip

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

apt-get clean
rm -rf /var/lib/apt/lists/*

