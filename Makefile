PROJECT="example"
VERSION=1.0.0
BUILD=`date +%FT%T%z`
# 获取grpc—gateway版本
GRPC_GATEWAY_VERSION=`go mod graph |grep fw |grep grpc-gateway | awk -F"@" '{print $$3}'`

build:generate
	@echo Generate binary file
	@go build -o ./bin/${PROJECT} ./internal/cmd/main.go
	@echo Generate binary file successfully

protobuf:
	@echo Generate gRPC stub
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@${GRPC_GATEWAY_VERSION}/third_party/googleapis \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--gogofast_out=plugins=grpc:. proto/*.proto
	@echo Generate gRPC stub successfully

generate:protobuf
	@echo Generate register.go file by protocol buffers
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway@${GRPC_GATEWAY_VERSION}/third_party/googleapis \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	./proto/*.proto --json_out=.
	@echo Generate register successfully