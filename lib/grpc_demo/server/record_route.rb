require 'grpc_demo/server/distance_helper'

module GrpcDemo
  class Server
    # RecordRoute will loop every Coordinate

    class RecordRoute
      class RouteSummaryExtractor
        include DistanceHelper

        attr_reader :distance, :locations_count, :started, :elapsed_time

        def initialize
          @distance, @locations_count = 0, 0, 0
          @started, @elapsed_time = 0, 0
        end

        def call(call)
          last = nil
          call.each_remote_read do |coordinate|
            name = DB.find(longitude: coordinate.longitude, latitude: coordinate.latitude) || ''
            @locations_count = @locations_count += 1 unless name == ''
            if last.nil?
              last = coordinate
              @started = Time.now.to_i
              next
            end
            @elapsed_time = @elapsed_time = Time.now.to_i - started
            @distance = @distance += calculate_distance(coordinate, last)
            last = coordinate
          end
          self
        end
      end

      private_constant :RouteSummaryExtractor

      attr_reader :stub_call, :route_summary_extractor

      def initialize(stub_call)
        @stub_call = stub_call
        @route_summary_extractor = RouteSummaryExtractor.new
      end

      def call
        route_summary = route_summary_extractor.call(stub_call)
        RouteSummary.new(locations_count: route_summary.locations_count,
                         distance: route_summary.distance,
                         elapsed_time: route_summary.elapsed_time)
      end
    end
  end
end
