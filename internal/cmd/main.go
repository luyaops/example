package main

import (
	impl "github.com/luyaops/example/internal/impl/service"
	pb "github.com/luyaops/example/proto"
	"github.com/luyaops/fw/common/log"
	"github.com/luyaops/fw/core"
)

func main() {
	// 初始化一个gRpc服务
	server := core.NewRpcServer()
	pb.RegisterSayServer(server.Server, &impl.SayServerImpl{})

	if err := server.Run(); err != nil {
		log.Fatalf("Failed to run rpc server: %v", err)
	}
}
