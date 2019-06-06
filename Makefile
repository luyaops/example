PROJECT="example"
VERSION=1.0.0
BUILD=`date +%FT%T%z`
MODFILE=./go.mod
GRPC_GATEWAY_VERSION=""
GRPC_GATEWAY_PROTO=src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis


ifeq ($(MODFILE), $(wildcard $(MODFILE)))
	# 获取grpc—gateway版本,
	GRPC_GATEWAY_VERSION=@`go mod graph |grep "^github.com/grpc-ecosystem/grpc-gateway@" | awk -F'@' '{print $$2}' |awk '{print $$1}'|head -n1`
	GRPC_GATEWAY_PROTO=pkg/mod/github.com/grpc-ecosystem/grpc-gateway${GRPC_GATEWAY_VERSION}/third_party/googleapis
endif

show:
	@echo $(GOPATH)/${GRPC_GATEWAY_PROTO}

build:generate
	@echo Generate binary file
	@go build -o ./bin/${PROJECT} ./internal/cmd/main.go
	@echo Generate binary file successfully

protobuf:
	@echo Generate gRPC stub
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/${GRPC_GATEWAY_PROTO} \
	--gogofast_out=plugins=grpc:. proto/*.proto
	@echo Generate gRPC stub successfully

generate:protobuf
	@echo Generate register.go file by protocol buffers
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/${GRPC_GATEWAY_PROTO} \
	./proto/*.proto --json_out=.
	@echo Generate register successfully
