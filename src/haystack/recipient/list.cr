struct Haystack::Recipient::List
  include Response

  getter data : Array(Recipient)?
end
