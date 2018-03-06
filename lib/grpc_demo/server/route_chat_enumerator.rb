module GrpcDemo
  class Server
    class RouteChatEnumerator
      def initialize(notes, received_notes)
        @notes = notes
        @received_notes = received_notes
      end

      def each_item
        return enum_for(:each_item) unless block_given?
        begin
          @notes.each do |n|
            key = {
              'latitude' => n.location.latitude,
              'longitude' => n.location.longitude
            }
            earlier_msgs = @received_notes[key]
            @received_notes[key] << n.message
            # send back the earlier messages at this point
            earlier_msgs.each do |r|
              yield RouteNote.new(location: n.location, message: r)
            end
          end
        rescue StandardError => e
          fail e # signal completion via an error
        end
      end
    end
  end
end
