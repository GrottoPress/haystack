struct Haystack::Recipient::Item
  include Response

  struct Resource
    getter data : Recipient?
  end
end
