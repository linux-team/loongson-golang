#!/bin/bash
WORKDIR=$(pwd)
TEMPDIR="/tmp/gccgo-build"
TEMPWORKDIR="$TEMPDIR/_$WORKDIR"
echo "$TEMPDIR/_$WORKDIR"
mkdir -p $TEMPWORKDIR/_obj
cd $WORKDIR
gccgo -I $TEMPDIR -c -g -fgo-relative-import-path="_$WORKDIR" -o $TEMPWORKDIR/_obj/main.o ./doc.go ./yacc.go

ar cru $TEMPWORKDIR/../libyacc.a $TEMPWORKDIR/_obj/main.o 
gccgo -o yacc $TEMPWORKDIR/_obj/main.o  -lpthread -Wl,-E 
