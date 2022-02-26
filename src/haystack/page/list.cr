struct Haystack::Page::List
  include Response

  struct Resource
    getter data : Array(Page)?
  end
end
