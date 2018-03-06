module GrpcDemo
  class Client
    class ListLocations
      AREA = Routeguide::Area.new(
        lo: Routeguide::Coordinate.new(latitude: 400_000_000, longitude: -750_000_000),
        hi: Routeguide::Coordinate.new(latitude: 420_000_000, longitude: -730_000_000))

      # runs a ListLocations rpc.
      #
      # - the rectangle to chosen to include most of the known features
      #   in the sample db.
      def self.call(stub)
        p 'ListLocations'
        p '------------'
        resps = stub.list_locations(AREA)
        resps.each do |r|
          p "- found '#{r.name}' at #{r.coordinates.inspect}"
        end
      end
    end
  end
end
