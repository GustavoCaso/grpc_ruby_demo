module GrpcDemo
  class Server
    # Locations provides an Enumerator of the Locations in a DB within a
    # given Area.

    class Locations
      # @param [Area] area
      def initialize(area)
        lats = [area.lo.latitude, area.hi.latitude]
        longs = [area.lo.longitude, area.hi.longitude]
        @lo_lat, @hi_lat = lats.min, lats.max
        @lo_long, @hi_long = longs.min, longs.max
      end

      # each yields the location lie within the instance of the area.
      def each
        return enum_for(:each) unless block_given?
        locations.each do |location|
          yield location
        end
      end

      private

      def locations
        return @locations if defined?(@locations)
        result = DB.data.each_with_object([]) do |(location, name), locations|
          next unless in?(location)
          next if name.nil? || name == ''
          coordinate = create_coordinate(location)
          locations << Location.new(coordinates: coordinate, name: name)
        end
        @locations = result
        @locations
      end

      def create_coordinate(location)
        Coordinate.new(Hash[location.each_pair.map { |k, v| [k.to_sym, v] }])
      end

      # in? determines if location lies within the area of this instances
      # Area.
      def in?(location)
        location['longitude'] >= @lo_long &&
          location['longitude'] <= @hi_long &&
          location['latitude'] >= @lo_lat &&
          location['latitude'] <= @hi_lat
      end
    end
  end
end
