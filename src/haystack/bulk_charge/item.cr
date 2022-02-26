struct Haystack::BulkCharge::Item
  include Response

  struct Resource
    getter data : BulkCharge?
  end
end
