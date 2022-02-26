struct Haystack::Plan::List
  include Response

  struct Resource
    getter data : Array(Plan)?
  end
end
