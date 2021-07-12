module Haystack::FromAny
  macro included
    def self.from_any(object) : self?
      case object
      when Int
        from_json(%({"id": #{object}}))
      else
        object
      end
    end
  end
end
