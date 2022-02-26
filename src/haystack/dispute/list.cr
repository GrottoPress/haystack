struct Haystack::Dispute::List
  include Response

  struct Resource
    getter data : Array(Dispute)?
  end
end
