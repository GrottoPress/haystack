module Haystack::FromAny
  macro included
    def self.from_any(object) : self?
      case object
      when Int
        from_json({id: object}.to_json)
      else
        object
      end
    end
  end
end
