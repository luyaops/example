build:
	@echo Generate gRPC stub
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--gogofast_out=plugins=grpc:. proto/*.proto
	@echo Generate Successfully

register:
	@echo Register gRPC to Etcd
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
    -I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	${GOPATH}/src/luyaops/example/proto/*.proto --parse_out=.
	@echo Register Successfully