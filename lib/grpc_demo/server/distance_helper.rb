module GrpcDemo
  class Server
    module DistanceHelper
      COORD_FACTOR = 1e7
      RADIUS = 637_100

      # Determines the distance between two points.
      def calculate_distance(coordinate_a, coordinate_b)
        to_radians = proc { |x| x * Math::PI / 180 }
        lat_a = coordinate_a.latitude / COORD_FACTOR
        lat_b = coordinate_b.latitude / COORD_FACTOR
        long_a = coordinate_a.longitude / COORD_FACTOR
        long_b = coordinate_b.longitude / COORD_FACTOR
        φ1 = to_radians.call(lat_a)
        φ2 = to_radians.call(lat_b)
        Δφ = to_radians.call(lat_a - lat_b)
        Δλ = to_radians.call(long_a - long_b)
        a = Math.sin(Δφ / 2)**2 +
            Math.cos(φ1) * Math.cos(φ2) +
            Math.sin(Δλ / 2)**2
        (2 * RADIUS *  Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))).to_i
      end
    end
  end
end
