#!/bin/bash
WORKDIR=$(pwd)
TEMPDIR="/tmp/gccgo-build"
TEMPWORKDIR="$TEMPDIR/_$WORKDIR"
echo "$TEMPDIR/_$WORKDIR"
mkdir -p $TEMPWORKDIR/_obj
cd $WORKDIR
gccgo-4.9 -I $TEMPDIR -c -g -fgo-relative-import-path="_$WORKDIR" -o $TEMPWORKDIR/_obj/main.o  ./ast.go ./zdefaultcc.go ./doc.go ./gcc.go ./godefs.go ./main.go ./out.go ./util.go

ar cru $TEMPWORKDIR/../libcgo.a $TEMPWORKDIR/_obj/main.o
gccgo-4.9 -o cgo $TEMPWORKDIR/_obj/main.o  -lpthread -Wl,-E
