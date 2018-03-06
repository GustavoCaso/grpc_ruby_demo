module GrpcDemo
  class Client
    class RouteChat
      ROUTE_CHAT_NOTES = [
        Routeguide::RouteNote.new(message: 'doh - a deer',
                      location: Routeguide::Point.new(latitude: 0, longitude: 0)),
        Routeguide::RouteNote.new(message: 'ray - a drop of golden sun',
                      location: Routeguide::Point.new(latitude: 0, longitude: 1)),
        Routeguide::RouteNote.new(message: 'me - the name I call myself',
                      location: Routeguide::Point.new(latitude: 1, longitude: 0)),
        Routeguide::RouteNote.new(message: 'fa - a longer way to run',
                      location: Routeguide::Point.new(latitude: 1, longitude: 1)),
        Routeguide::RouteNote.new(message: 'soh - with needle and a thread',
                      location: Routeguide::Point.new(latitude: 0, longitude: 1))
      ]

      # SleepingEnumerator yields through items, and sleeps between each one
      class SleepingEnumerator
        def initialize(items, delay)
          @items = items
          @delay = delay
        end
        def each_item
          return enum_for(:each_item) unless block_given?
          @items.each do |item|
            sleep @delay
            p "next item to send is #{item.inspect}"
            yield item
          end
        end
      end

      private_constant :SleepingEnumerator

      # runs a RouteChat rpc.
      #
      # sends a canned set of route notes and prints out the responses.
      def self.call(stub)
        p 'Route Chat'
        p '----------'
        sleeping_enumerator = SleepingEnumerator.new(ROUTE_CHAT_NOTES, 1)
        stub.route_chat(sleeping_enumerator.each_item) { |r| p "received #{r.inspect}" }
      end
    end
  end
end
