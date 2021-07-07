struct Haystack::Transaction::List
  include Response

  getter data : Array(Transaction)?
end
