#!/bin/bash
GOROOT=$(pwd)
GOROOT=${GOROOT%/deepin*}
echo "GOROOT:$GOROOT"
export GOROOT=$GOROOT
export GOTOOLDIR="$GOROOT/bin"
echo  "GOTOOLDIR:$GOTOOLDIR"
mkdir $GOROOT/bin
#rm $GOTOOLDIR/go
#rm $GOTOOLDIR/gofmt
CURDIR=$(pwd)
#   echo "$CURDIR"
cp ./buildgo.bash ../src/cmd/go/buildgo.sh
cp ./zdefaultcc.go ../src/cmd/go
mv ../src/cmd/go/pkg.go ../src/cmd/go/pkg_backup
cp ./pkg.go ../src/cmd/go/pkg.go

cd ../src/cmd/go
chmod 777 buildgo.sh
./buildgo.sh
cp ./go $GOTOOLDIR/
rm buildgo.sh go zdefaultcc.go pkg.go
mv pkg_backup pkg.go
echo "go installed succeed"
cd $CURDIR
echo "$(pwd)"

#安装gofmt
cp ./buildgofmt.bash ../src/cmd/gofmt/buildgofmt.sh
cd ../src/cmd/gofmt
chmod 777 buildgofmt.sh
./buildgofmt.sh
cp ./gofmt $GOTOOLDIR/
rm buildgofmt.sh gofmt
cd $CURDIR

echo "*** installed go and gofmt in $GOTOOLDIR ***"
echo "请将环境变量GOROOT设置为$GOROOT\
		 将$GOROOT/bin 添加到PATH路径中去"
