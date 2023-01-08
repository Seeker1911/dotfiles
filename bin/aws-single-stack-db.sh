#!/bin/bash

dns_suffix=import-api
aws ssm get-parameter --name /single-stack/${dns_suffix}/mysql_password --with-decryption
#If your stack uses RDS, you will also want to pull the following items:
aws ssm get-parameter --name /single-stack/${dns_suffix}/mysql_host --with-decryption
aws ssm get-parameter --name /single-stack/${dns_suffix}/mysql_user --with-decryption
