#!/bin/bash

ACCOUNT=$(aws sts get-caller-identity)
echo $ACCOUNT
echo ---------------

ACCOUNTKEYVALUE="$(cut -d',' -f2 <<< ${ACCOUNT})"
STRINGACCOUNTKEY="$(cut -d':' -f2 <<< $ACCOUNTKEYVALUE)"
ACCOUNTNUMBER="$(cut -d'"' -f2 <<< $STRINGACCOUNTKEY)"
echo $ACCOUNTNUMBER

aws ecr get-login-password --region us-east-1 | docker login \
--username AWS \
--password-stdin $ACCOUNTNUMBER.dkr.ecr.us-east-1.amazonaws.com

echo "Done"
