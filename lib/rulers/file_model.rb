require "multi_json"
module Rulers
  module Model
    class FileModel
      def initialize(filename)
        @filename = filename

        #if file name is 'dir/37.json', @id is 37
        basename = File.split(filename)[-1] #/path/path/1.json => 1.json
        @id = File.basename(basename, ".json").to_i #1.json => 1

        obj = File.read(filename)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.all
        files = Dir["db/quotes/*.json"]

        files.map { |f| FileModel.new(f) }
      end

      def self.find(id)
        begin
          FileModel.new("db/quotes/#{id}.json")
        rescue
          return nil
        end
      end
    end
  end
end
