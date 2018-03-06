module GrpcDemo
  class Server
    # RectangleEnum provides an Enumerator of the points in a feature_db within a
    # given Rectangle.

    class RectangleEnum
      # @param [Rectangle] rectangle
      def initialize(rectangle)
        lats = [rectangle.lo.latitude, rectangle.hi.latitude]
        longs = [rectangle.lo.longitude, rectangle.hi.longitude]
        @lo_lat, @hi_lat = lats.min, lats.max
        @lo_long, @hi_long = longs.min, longs.max
      end

      # in? determines if location lies within the rectangle of this instances
      # Rectangle.
      def in?(location)
        location['longitude'] >= @lo_long &&
          location['longitude'] <= @hi_long &&
          location['latitude'] >= @lo_lat &&
          location['latitude'] <= @hi_lat
      end

      # each yields the features in the instances feature_db that lie within the
      # instance rectangle.
      def each
        return enum_for(:each) unless block_given?
        DB.data.each_pair do |location, name|
          next unless in?(location)
          next if name.nil? || name == ''
          pt = Point.new(
            Hash[location.each_pair.map { |k, v| [k.to_sym, v] }])
          yield Feature.new(location: pt, name: name)
        end
      end
    end
  end
end
