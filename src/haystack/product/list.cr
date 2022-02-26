struct Haystack::Product::List
  include Response

  struct Resource
    getter data : Array(Product)?
  end
end
