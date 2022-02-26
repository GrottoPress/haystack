struct Haystack::Customer::Item
  include Response

  struct Resource
    getter data : Customer?
  end
end
