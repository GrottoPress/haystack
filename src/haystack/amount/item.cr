struct Haystack::Amount::Item
  include Response

  struct Resource
    getter data : Amount?
  end
end
