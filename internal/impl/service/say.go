package service

import (
	"golang.org/x/net/context"
	pb "luyaops/example/service"
	"net/http"
)

type SayServerImpl struct {
	//core.InjectionService
}

func (s *SayServerImpl) Echo(ctx context.Context, req *pb.HelloRequest) (*pb.EchoResponse, error) {
	return &pb.EchoResponse{
		Data: "echo ...",
		Code: http.StatusOK,
	}, nil
}

func (s *SayServerImpl) Hello(ctx context.Context, req *pb.HelloRequest) (*pb.EchoResponse, error) {
	return &pb.EchoResponse{
		Data: "hello " + req.Name,
		Code: http.StatusOK,
	}, nil
}