struct Haystack::Customer::List
  include Response

  getter data : Array(Customer)?
end
