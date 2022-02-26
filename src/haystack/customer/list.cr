struct Haystack::Customer::List
  include Response

  struct Resource
    getter data : Array(Customer)?
  end
end
