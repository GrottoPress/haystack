struct Haystack::Transfer::Item
  include Response

  struct Resource
    getter data : Transfer?
  end
end
