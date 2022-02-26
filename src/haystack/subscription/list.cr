struct Haystack::Subscription::List
  include Response

  struct Resource
    getter data : Array(Subscription)?
  end
end
