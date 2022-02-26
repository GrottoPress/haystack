struct Haystack::Export::Item
  include Response

  struct Resource
    getter data : Export?
  end
end
