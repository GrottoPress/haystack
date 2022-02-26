struct Haystack::Transfer::List
  include Response

  struct Resource
    getter data : Array(Transfer)?
  end
end
