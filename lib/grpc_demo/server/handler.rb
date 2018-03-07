require 'grpc_demo/server/locations'
require 'grpc_demo/server/record_route'
require 'grpc_demo/server/route_chat_enumerator'

module GrpcDemo
  class Server
    class Handler < Routeguide::RouteGuide::Service
      def initialize
        @received_notes = Hash.new { |h, k| h[k] = [] }
      end

      def get_location(coordinates, _call)
        name = DB.find(longitude: coordinates.longitude, latitude: coordinates.latitude) || ''
        Location.new(coordinates: coordinates, name: name)
      end

      def list_locations(area, _call)
        Locations.new(area).each
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
