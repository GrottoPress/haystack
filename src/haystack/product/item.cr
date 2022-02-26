struct Haystack::Product::Item
  include Response

  struct Resource
    getter data : Product?
  end
end
