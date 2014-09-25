#!/bin/bash
WORKDIR=$(pwd)
TEMPDIR="/tmp/gccgo-build"
TEMPWORKDIR="$TEMPDIR/_$WORKDIR"
echo "$TEMPDIR/_$WORKDIR"
mkdir -p $TEMPWORKDIR/_obj
cd $WORKDIR
gccgo -I $TEMPDIR -c -g -fgo-relative-import-path="_$WORKDIR" \
 -o $TEMPWORKDIR/_obj/main.o ./build.go ./clean.go ./context.go ./discovery.go ./doc.go ./env.go ./fix.go ./fmt.go ./get.go ./go11.go ./help.go ./http.go ./list.go ./main.go ./pkg.go ./run.go ./signal.go ./signal_unix.go ./test.go ./testflag.go ./tool.go ./vcs.go ./version.go ./vet.go ./zdefaultcc.go
ar cru $TEMPWORKDIR/../libgo.a $TEMPWORKDIR/_obj/main.o 
gccgo -o go $TEMPWORKDIR/_obj/main.o  -lpthread -Wl,-E 
