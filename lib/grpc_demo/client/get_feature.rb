module GrpcDemo
  class Client
    class GetFeature

      GET_FEATURE_POINTS = [
        Routeguide::Point.new(latitude:  409_146_138, longitude: -746_188_906),
        Routeguide::Point.new(latitude:  0, longitude: 0)
      ]

      # runs a GetFeature rpc.
      #
      # - once with a point known to be present in the sample route database
      # - once with a point that is not in the sample database
      def self.call(stub)
        p 'GetFeature'
        p '----------'
        GET_FEATURE_POINTS.each do |pt|
          resp = stub.get_feature(pt)
          if resp.name != ''
            p "- found '#{resp.name}' at #{pt.inspect}"
          else
            p "- found nothing at #{pt.inspect}"
          end
        end
      end
    end
  end
end
