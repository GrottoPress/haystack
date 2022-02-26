struct Haystack::Split::Item
  include Response

  struct Resource
    getter data : Split?
  end
end
