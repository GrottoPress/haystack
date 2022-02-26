struct Haystack::Dispute::Item
  include Response

  struct Resource
    getter data : Dispute?
  end
end
