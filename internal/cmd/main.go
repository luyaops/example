package main

import (
	"google.golang.org/grpc"
	"log"
	impl "luyaops/example/internal/impl/service"
	pb "luyaops/example/service"
	"net"
)

type RpcHosting struct {
	Server *grpc.Server
	listen net.Listener
}

func NewRpcHosting() *RpcHosting {
	server := grpc.NewServer()
	return &RpcHosting{Server: server}
}

func (s *RpcHosting) Run() error {
	lis, err := net.Listen("tcp", "0.0.0.0:50051")
	if err != nil {
		return err
	}
	s.listen = lis
	return s.Server.Serve(s.listen)
}

func main() {
	host := NewRpcHosting()
	pb.RegisterSayServer(host.Server, &impl.SayServerImpl{})

	if err := host.Run(); err != nil {
		log.Fatalf("Failed to host run: %v", err)
	}
}
