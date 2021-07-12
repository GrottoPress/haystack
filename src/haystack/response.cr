module Haystack::Response
  macro included
    include JSON::Serializable

    getter status : ::Bool
    getter message : String
    getter meta : Meta?

    def success? : ::Bool
      status
    end
  end
end
