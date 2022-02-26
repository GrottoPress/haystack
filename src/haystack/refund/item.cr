struct Haystack::Refund::Item
  include Response

  struct Resource
    getter data : Refund?
  end
end
