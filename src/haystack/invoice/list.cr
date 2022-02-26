struct Haystack::Invoice::List
  include Response

  getter data : Array(Invoice)?
end
