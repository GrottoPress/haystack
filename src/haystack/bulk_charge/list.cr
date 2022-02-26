struct Haystack::BulkCharge::List
  include Response

  struct Resource
    getter data : Array(BulkCharge)?
  end
end
