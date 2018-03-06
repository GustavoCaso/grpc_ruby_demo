require 'grpc_demo/client/get_feature'
require 'grpc_demo/client/list_features'
require 'grpc_demo/client/route_chat'
require 'grpc_demo/client/record_route'


module GrpcDemo
  class Client
    class << self
      def get_feature
        GetFeature.call(stub)
      end

      def list_features
        ListFeatures.call(stub)
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
