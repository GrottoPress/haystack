struct Haystack::Plan::Item
  include Response

  struct Resource
    getter data : Plan?
  end
end
