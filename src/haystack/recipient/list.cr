struct Haystack::Recipient::List
  include Response

  struct Resource
    getter data : Array(Recipient)?
  end
end
