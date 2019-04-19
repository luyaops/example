PROJECT="example"
VERSION=1.0.0
BUILD=`date +%FT%T%z`


build:generate
	@echo Generate binary file
	@go build -o ./bin/${PROJECT} ./internal/cmd/main.go
	@echo Generate binary file successfully

proto:
	@echo Generate gRPC stub
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--gogofast_out=plugins=grpc:. proto/*.proto
	@echo Generate gRPC stub successfully

generate:proto
	@echo Generate register.go file by protocol buffers
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
    -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	${GOPATH}/src/github.com/luyaops/example/proto/*.proto --json_out=.
	@echo Generate register successfully