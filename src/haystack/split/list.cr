struct Haystack::Split::List
  include Response

  struct Resource
    getter data : Array(Split)?
  end
end
