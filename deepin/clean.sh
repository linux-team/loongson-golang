#!/bin/bash
GOROOT=$(pwd)
GOROOT=${GOROOT%/deepin*}
GOROOT=$GOROOT
GOBIN="$GOROOT/bin"
rm -r $GOBIN/*
rm -r $GOROOT/pkg/tool/linux_mipso32
