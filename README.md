# gRPC-Gateway Example

## 1、安装gRPC
```shell
go get -u google.golang.org/grpc

上面命令被墙，并且源码已经托管至github上了。用以下命令安装。
git clone https://github.com/grpc/grpc-go.git $GOPATH/src/google.golang.org/grpc
git clone https://github.com/golang/net.git $GOPATH/src/golang.org/x/net
git clone https://github.com/golang/text.git $GOPATH/src/golang.org/x/text
git clone https://github.com/golang/sys.git $GOPATH/src/golang.org/x/sys
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
git clone https://github.com/google/go-genproto.git $GOPATH/src/google.golang.org/genproto

cd $GOPATH/src/
go install google.golang.org/grpc

```

## 2、安装ProtocolBuffers
```shell
安装所需包：
sudo apt-get install autoconf automake libtool curl make g++ unzip 

git clone https://github.com/google/protobuf
cd protobuf
./autogen.sh
./configure
make
make check
make install
sudo ldconfig

go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/github.com/luyaops/fw/protoc-gen-json   //用于生成服务注册文件
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
go get -u github.com/golang/protobuf/protoc-gen-go
go get -u github.com/gogo/protobuf/protoc-gen-gogofast //更快更多的生成代码 
```
关于[gogo](https://github.com/gogo/protobuf)

## 3、生成go版本的gRPC存根
```shell
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --gogofast_out=plugins=grpc:. \
  path/to/your_service.proto
```
将生成存根文件 path/to/your_service.pb.go

## 4、生成反向代理（可选）
```shell
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:. \
  path/to/your_service.proto
```
假如报：protoc-gen-grpc-gateway: program not found or is not executable

cd $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && go install

会在 $GOPATH/bin 目录下创建protoc-gen-grpc-gateway 可执行文件
## 5、生成swagger（可选）
```shell
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --swagger_out=logtostderr=true:. \
  path/to/your_service.proto
```

## 6、参考文章
* https://grpc-ecosystem.github.io/grpc-gateway/docs/usage.html
* https://github.com/gogo/protobuf


## 7、 Make使用
* make proto 生成 pb.go文件
* make generate 生成注册文件