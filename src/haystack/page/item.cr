struct Haystack::Page::Item
  include Response

  struct Resource
    getter data : Page?
  end
end
