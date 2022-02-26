struct Haystack::Refund::List
  include Response

  struct Resource
    getter data : Array(Refund)?
  end
end
