struct Haystack::Subscription::List
  include Response

  getter data : Array(Subscription)?
end
