all: build

build:
	bundle exec grpc_tools_ruby_protoc -I ./protos --ruby_out=./lib/grpc_demo/rpc --grpc_out=./lib/grpc_demo/rpc ./protos/route_guide.proto
	sed -i '' "s/require 'route_guide_pb'/require_relative 'route_guide_pb'/" ./lib/grpc_demo/rpc/route_guide_services_pb.rb
