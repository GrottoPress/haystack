struct Haystack::Transaction::Item
  include Response

  struct Resource
    getter data : Transaction?
  end
end
