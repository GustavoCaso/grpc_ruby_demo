require 'grpc_demo/server/rectangle_enum'
require 'grpc_demo/server/record_route'
require 'grpc_demo/server/route_chat_enumerator'

module GrpcDemo
  class Server
    class Handler < Routeguide::RouteGuide::Service
      def initialize
        @received_notes = Hash.new { |h, k| h[k] = [] }
      end

      def get_feature(point, _call)
        name = DB.find(longitude: point.longitude, latitude: point.latitude) || ''
        Feature.new(location: point, name: name)
      end

      def list_features(rectangle, _call)
        RectangleEnum.new(rectangle).each
      end

      def record_route(call)
        RecordRoute.new(call).call
      end

      def route_chat(notes)
        RouteChatEnumerator.new(notes, @received_notes).each_item
      end
    end
  end
end
