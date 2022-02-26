struct Haystack::Recipient::Bulk
  include Hapi::Resource

  getter success : Array(Recipient)
  getter errors : Array(JSON::Any) # Figure out type

  struct Item
    include Response

    struct Resource
      getter data : Bulk?
    end
  end
end
