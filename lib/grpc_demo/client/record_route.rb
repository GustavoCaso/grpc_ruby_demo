require 'multi_json'

module GrpcDemo
  class Client
    class RecordRoute
      # RandomRoute provides an Enumerable that yields a random 'route' of points
      # from a list of Features.
      class RandomRoute
        def initialize(features, size)
          @features = features
          @size = size
        end

        # yields a point, waiting between 0 and 1 seconds between each yield
        #
        # @return an Enumerable that yields a random point
        def each
          return enum_for(:each) unless block_given?
          @size.times do
            json_feature = @features[rand(0..@features.length)]
            next if json_feature.nil?
            location = json_feature['location']
            pt = Routeguide::Coordinate.new(
              Hash[location.each_pair.map { |k, v| [k.to_sym, v] }])
            p "- next point is #{pt.inspect}"
            yield pt
            sleep(rand(0..1))
          end
        end
      end

      private_constant :RandomRoute

      # runs a RecordRoute rpc.
      #
      # - the rectangle to chosen to include most of the known features
      #   in the sample db.
      def self.call(stub)
        p 'RecordRoute'
        p '-----------'
        points_on_route = 10  # arbitrary
        reqs = RandomRoute.new(features, points_on_route)
        resp = stub.record_route(reqs.each)
        p "summary: #{resp.inspect}"
      end

      def self.features
        raw_data = []
        File.open(DB::DB_FILE) do |f|
          raw_data = MultiJson.load(f.read)
        end
        Hash[raw_data.map { |x| [x['location'], x['name']] }]
      end
    end
  end
end
