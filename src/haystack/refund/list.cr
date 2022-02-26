struct Haystack::Refund::List
  include Response

  getter data : Array(Refund)?
end
