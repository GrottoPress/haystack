module Haystack::Response
  macro included
    include Hapi::Resource

    getter status : ::Bool
    getter message : String
    getter meta : Meta?

    def success? : ::Bool
      status
    end
  end
end
