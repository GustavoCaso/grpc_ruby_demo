require 'grpc_demo/server/distance_helper'

module GrpcDemo
  class Server
    # RecordRoute will loop every Point

    class RecordRoute
      class RouteSummaryExtractor
        include DistanceHelper

        attr_reader :distance, :count, :feature_count, :started, :elapsed_time

        def initialize
          @distance, @count, @feature_count = 0, 0, 0
          @started, @elapsed_time = 0, 0
        end

        def call(call)
          last = nil
          call.each_remote_read do |point|
            @count = @count += 1
            name = DB.find(longitude: point.longitude, latitude: point.latitude) || ''
            @features = @features += 1 unless name == ''
            if last.nil?
              last = point
              @started = Time.now.to_i
              next
            end
            @elapsed_time = @elapsed_time = Time.now.to_i - started
            @distance = @distance += calculate_distance(point, last)
            last = point
          end
          self
        end
      end

      attr_reader :stub_call, :route_summary_extractor

      def initialize(stub_call)
        @stub_call = stub_call
        @route_summary_extractor = RouteSummaryExtractor.new
      end

      def call
        route_summary = route_summary_extractor.call(stub_call)
        RouteSummary.new(point_count: route_summary.count,
                         feature_count: route_summary.feature_count,
                         distance: route_summary.distance,
                         elapsed_time: route_summary.elapsed_time)
      end
    end
  end
end
