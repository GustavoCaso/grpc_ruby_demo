require "grpc_demo/version"
require 'grpc_demo/rpc/route_guide_services_pb'
require "grpc_demo/db"
require "grpc_demo/client"
require "grpc_demo/server"

include Routeguide

module GrpcDemo
  PORT = '50051'

  def self.start_server
    Server.start
  end

  def self.client_get_feature
    Client.get_feature
  end

  def self.client_list_features
    Client.list_features
  end

  def self.client_route_chat
    Client.route_chat
  end

  def self.client_record_route
    Client.record_route
  end
end
