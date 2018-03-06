module GrpcDemo
  class Client
    class ListFeatures
      LIST_FEATURES_RECT = Routeguide::Rectangle.new(
        lo: Routeguide::Point.new(latitude: 400_000_000, longitude: -750_000_000),
        hi: Routeguide::Point.new(latitude: 420_000_000, longitude: -730_000_000))

      # runs a ListFeatures rpc.
      #
      # - the rectangle to chosen to include most of the known features
      #   in the sample db.
      def self.call(stub)
        p 'ListFeatures'
        p '------------'
        resps = stub.list_features(LIST_FEATURES_RECT)
        resps.each do |r|
          p "- found '#{r.name}' at #{r.location.inspect}"
        end
      end
    end
  end
end
