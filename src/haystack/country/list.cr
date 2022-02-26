struct Haystack::Country::List
  include Response

  struct Resource
    getter data : Array(Country)?
  end
end
