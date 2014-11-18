#!/bin/bash
WORKDIR=$(pwd)
TEMPDIR="/tmp/gccgo-build"
TEMPWORKDIR="$TEMPDIR/_$WORKDIR"
echo "$TEMPDIR/_$WORKDIR"
mkdir -p $TEMPWORKDIR/_obj
cd $WORKDIR
gccgo-4.9 -I $TEMPDIR -c -g -fgo-relative-import-path="_$WORKDIR" -o $TEMPWORKDIR/_obj/main.o  ./doc.go ./pack.go
ar cru $TEMPWORKDIR/../libpack.a $TEMPWORKDIR/_obj/main.o
gccgo-4.9 -o pack $TEMPWORKDIR/_obj/main.o  -lpthread -Wl,-E
