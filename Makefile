build:
	@echo Generate gRPC stub
	@protoc -I/usr/local/include -I. -I$(GOPATH)/src \
	-I$(GOPATH)/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
	--gogofast_out=plugins=grpc:. service/*.proto
	@echo Generate Successfully
