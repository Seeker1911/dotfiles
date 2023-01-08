#!/bin/bash

export TF_DATA_DIR=$1
cd tf
../_tmp/terraform state replace-provider "registry.terraform.io/-/aws" "registry.terraform.io/hashicorp/aws"
../_tmp/terraform state replace-provider "registry.terraform.io/-/external" "registry.terraform.io/hashicorp/external"
../_tmp/terraform state replace-provider "registry.terraform.io/-/datadog" "registry.terraform.io/datadog/datadog"
../_tmp/terraform state replace-provider "registry.terraform.io/-/credstash" "registry.terraform.io/terraform-mars/credstash"
