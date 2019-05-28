package service

import (
	pb "github.com/luyaops/example/proto"
	"golang.org/x/net/context"
	"net/http"
)

type SayServerImpl struct {
	//core.InjectionService
}

func (s *SayServerImpl) Echo(ctx context.Context, req *pb.HelloRequest) (*pb.EchoResponse, error) {
	return &pb.EchoResponse{
		Data: "echo ... ping",
		Code: http.StatusOK,
	}, nil
}

func (s *SayServerImpl) Hello(ctx context.Context, req *pb.HelloRequest) (*pb.EchoResponse, error) {
	return &pb.EchoResponse{
		Data: "hello " + req.Name,
		Code: http.StatusOK,
	}, nil
}
