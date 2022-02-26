struct Haystack::Recipient::Bulk
  include Hapi::Resource

  getter success : Array(Recipient)
  getter errors : Array(JSON::Any) # Figure out type

  struct Item
    include Response

    getter data : Bulk?
  end
end
