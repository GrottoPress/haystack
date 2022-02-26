struct Haystack::Invoice::List
  include Response

  struct Resource
    getter data : Array(Invoice)?
  end
end
