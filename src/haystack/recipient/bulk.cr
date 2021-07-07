struct Haystack::Recipient::Bulk
  include JSON::Serializable

  getter success : Array(Recipient)
  getter errors : Array(JSON::Any) # Figure out type

  struct Item
    include Response

    getter data : Bulk?
  end
end
