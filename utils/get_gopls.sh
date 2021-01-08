#!/bin/bash
cd ~/go
GO111MODULE=on go get golang.org/x/tools/gopls@latest 
go get -u golang.org/x/tools/...
