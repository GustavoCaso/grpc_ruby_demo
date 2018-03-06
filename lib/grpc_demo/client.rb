require 'grpc_demo/client/get_location'
require 'grpc_demo/client/list_locations'
require 'grpc_demo/client/route_chat'
require 'grpc_demo/client/record_route'


module GrpcDemo
  class Client
    class << self
      def get_location
        GetLocation.call(stub)
      end

      def list_locations
        ListLocations.call(stub)
      end

      def route_chat
        RouteChat.call(stub)
      end

      def record_route
        RecordRoute.call(stub)
      end

      private

      def stub
        @stub ||= Routeguide::RouteGuide::Stub.new("localhost:#{GrpcDemo::PORT}", :this_channel_is_insecure)
      end
    end
  end
end
