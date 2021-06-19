#!/bin/bash

function tail_logs {
	aws logs tail ipro-item-api --follow
}

function ssh_ec2_bak {
    ssh -i "ipro_mmead_rsa" mmead@ec2-18-234-192-233.compute-1.amazonaws.com
}
