require 'multi_json'

module GrpcDemo
  class DB
    DB_FILE = 'route_guide_db.json'

    class << self
      def find(longitude:, latitude:)
        data[{'longitude' => longitude, 'latitude' => latitude }]
      end

      def data
        return @data if defined?(@data)
        raw_data = []
        File.open(DB_FILE) do |f|
          raw_data = MultiJson.load(f.read)
        end
        @data = Hash[raw_data.map { |x| [x['location'], x['name']] }]
      end
    end
  end
end
