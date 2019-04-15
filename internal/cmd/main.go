package main

import (
	"log"
	impl "luyaops/example/internal/impl/service"
	pb "luyaops/example/proto"
	"luyaops/fw/core"
)

func main() {
	host := core.NewRpcHosting()
	pb.RegisterSayServer(host.Server, &impl.SayServerImpl{})

	if err := host.Run(); err != nil {
		log.Fatal("Failed to host run: %v", err)
	}
}
