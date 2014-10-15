#!/bin/bash
GOROOT=$(pwd)
GOROOT=${GOROOT%/deepin*}
echo "GOROOT:$GOROOT"
export GOROOT=$GOROOT
export GOBIN="$GOROOT/bin"
echo  "GOBIN:$GOBIN"
CURDIR=$(pwd)
#   echo "$CURDIR"
#	安装go命令
cp ./buildgo.bash ../src/cmd/go/buildgo.sh
cp ./zdefaultcc.go ../src/cmd/go
mv ../src/cmd/go/pkg.go ../src/cmd/go/pkg_backup
cp ./pkg.go ../src/cmd/go/pkg.go

cd ../src/cmd/go
chmod 777 ./buildgo.sh
./buildgo.sh
cp ./go $GOBIN/
rm ./buildgo.sh ./go ./zdefaultcc.go ./pkg.go
mv ./pkg_backup ./pkg.go
echo "go installed succeed"
cd $CURDIR
echo "$(pwd)"

#安装gofmt
cp ./buildgofmt.bash ../src/cmd/gofmt/buildgofmt.sh
cd ../src/cmd/gofmt
chmod 777 ./buildgofmt.sh
./buildgofmt.sh
cp ./gofmt $GOBIN/
rm ./buildgofmt.sh ./gofmt
cd $CURDIR

# 安装go tools
GOTOOLDIR=$GOROOT/pkg/tool/linux_mipso32
mkdir $GOTOOLDIR
echo "GOTOOLDIR = $GOTOOLDIR"
#安装cgo
cp ./buildcgo.bash ../src/cmd/cgo/buildcgo.sh
cp ./zdefaultcc.go ../src/cmd/cgo/
mv ../src/cmd/cgo/main.go ../src/cmd/cgo/oldmain_go
cp ./main.go ../src/cmd/cgo/
cd ../src/cmd/cgo
chmod 777 buildcgo.sh
./buildcgo.sh
cp ./cgo $GOTOOLDIR
rm ./main.go
mv ./oldmain_go ./main.go
rm ./cgo
rm ./buildcgo.sh
cd $CURDIR

#编译fix
cp ./buildfix.bash ../src/cmd/fix/buildfix.sh
cd ../src/cmd/fix
chmod 777 buildfix.sh
./buildfix.sh
mv ./fix $GOTOOLDIR/
rm buildfix.sh
cd $CURDIR

# 安装pack
cp ./buildpack.bash ../src/cmd/pack/buildpack.sh
cd ../src/cmd/pack
chmod 777 buildpack.sh
./buildpack.sh
cp ./pack $GOTOOLDIR/
rm buildpack.sh pack
cd $CURDIR

# 安装yacc
cp ./buildyacc.bash ../src/cmd/yacc/buildyacc.sh
cd ../src/cmd/yacc
chmod 777 buildyacc.sh
./buildyacc.sh
cp ./yacc $GOTOOLDIR/
rm buildyacc.sh yacc
cd $CURDIR




echo "*** installed go and gofmt in $GOTOOLDIR ***"
echo "    请设置环境变量GOROOT和PATH:
	 export GOROOT=$GOROOT	
	 export PATH=\$PATH:$GOBIN
	 然后就可以使用如下命令编译golang工程:
	 go build -compiler=gccgo"
