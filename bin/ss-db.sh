#!/bin/bash

# use: awslogin prod-integrations then ss-db [name of dns service for single stack]
 ss-db() {
   ss=$1
   host=$(waws prod-integrations aws ssm get-parameter --region us-east-1 --with-decryption --name "/single-stack/$ss/mysql_host" | jq '.Parameter.Value')
   user=$(waws prod-integrations aws ssm get-parameter --region us-east-1 --with-decryption --name "/single-stack/$ss/mysql_user" | jq '.Parameter.Value')
   pass=$(waws prod-integrations aws ssm get-parameter --region us-east-1 --with-decryption --name "/single-stack/$ss/mysql_password" | jq '.Parameter.Value')
   echo -e "Host: $host\nUser: $user\nPassword: $pass"
 }
 
 waws() {
   key=$1;shift
   AWS_SHARED_CREDENTIALS_FILE="~/.aws/$key" "$@"
 }
