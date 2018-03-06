require 'grpc'
require 'grpc_demo/server/handler'

module GrpcDemo
  class Server
    class << self
      def start
        grpc_server = build_server
        puts("... running insecurely on #{GrpcDemo::PORT}")
        grpc_server.run_till_terminated
      end

      private

      def build_server
        GRPC::RpcServer.new.tap do |server|
          server.add_http2_port("0.0.0.0:#{GrpcDemo::PORT}", :this_port_is_insecure)
          server.handle(Handler.new)
        end
      end
    end
  end
end
