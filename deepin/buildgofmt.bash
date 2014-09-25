#!/bin/bash
WORKDIR=$(pwd)
TEMPDIR="/tmp/gccgo-build"
TEMPWORKDIR="$TEMPDIR/_$WORKDIR"
echo "$TEMPDIR/_$WORKDIR"
mkdir -p $TEMPWORKDIR/_obj
cd $WORKDIR
gccgo -I $TEMPDIR -c -g -fgo-relative-import-path="_$WORKDIR" -o $TEMPWORKDIR/_obj/main.o  ./doc.go ./gofmt.go ./rewrite.go ./simplify.go
ar cru $TEMPWORKDIR/../libgofmt.a $TEMPWORKDIR/_obj/main.o 
gccgo -o gofmt $TEMPWORKDIR/_obj/main.o  -lpthread -Wl,-E 
