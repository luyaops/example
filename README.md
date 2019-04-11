# gRPC-Gateway Example

## 1、安装gRPC
```shell
go get -u get google.golang.org/grpc
```

## 2、安装ProtocolBuffers
```shell
git clone https://github.com/google/protobuf
cd protobuf
./autogen.sh
./configure
make
make check
make install

go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
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