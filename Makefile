build:
	@echo Generate gRPC stub
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--gogofast_out=plugins=grpc:. proto/*.proto
	@echo Generate Successfully

generate:
	@echo Generate register.go file by protocol buffers
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
    -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	${GOPATH}/src/github.com/luyaops/example/proto/*.proto --json_out=.
	@echo Generate Successfully