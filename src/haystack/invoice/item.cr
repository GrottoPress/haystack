struct Haystack::Invoice::Item
  include Response

  struct Resource
    getter data : Invoice?
  end
end
