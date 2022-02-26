module Haystack::Response
  macro included
    getter raw : HTTP::Client::Response

    def initialize(@raw)
      @resource = Resource.from_json(@raw.body_io)
    end

    forward_missing_to @resource

    struct Resource
      include Hapi::Resource

      getter status : ::Bool
      getter message : String
      getter meta : Meta?

      def success? : ::Bool
        status
      end
    end
  end
end
