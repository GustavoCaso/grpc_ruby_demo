require "grpc_demo/version"
require 'grpc_demo/rpc/route_guide_services_pb'
require "grpc_demo/db"
require "grpc_demo/server"

include Routeguide

module GrpcDemo
  PORT = '50051'

  def self.start_server
    Server.start
  end
end
