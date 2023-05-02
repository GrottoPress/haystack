struct Haystack::Recipient::Bulk
  include Haystack::Resource

  getter success : Array(Recipient)
  getter errors : Array(JSON::Any) # Figure out type

  struct Item
    include Response

    getter data : Bulk?
  end
end
