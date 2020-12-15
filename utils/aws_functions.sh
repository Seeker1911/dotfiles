#!/bin/bash

function tail_logs {
	aws logs tail ipro-item-api --follow
}

