struct Haystack::Settlement::List
  include Response

  struct Resource
    getter data : Array(Settlement)?
  end
end
