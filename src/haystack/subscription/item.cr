struct Haystack::Subscription::Item
  include Response

  struct Resource
    getter data : Subscription?
  end
end
