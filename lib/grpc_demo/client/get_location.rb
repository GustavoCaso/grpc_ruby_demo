module GrpcDemo
  class Client
    class GetLocation

      COORDINATES = [
        Routeguide::Coordinate.new(latitude:  409_146_138, longitude: -746_188_906),
        Routeguide::Coordinate.new(latitude:  0, longitude: 0)
      ]

      # runs a GetCoordinate rpc.
      #
      # - once with a point known to be present in the sample route database
      # - once with a point that is not in the sample database
      def self.call(stub)
        p 'GetLocation'
        p '----------'
        COORDINATES.each do |coordinate|
          resp = stub.get_location(coordinate)
          if resp.name != ''
            p "- found '#{resp.name}' at #{coordinate.inspect}"
          else
            p "- found nothing at #{coordinate.inspect}"
          end
        end
      end
    end
  end
end
