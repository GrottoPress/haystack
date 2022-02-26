struct Haystack::Transaction::List
  include Response

  struct Resource
    getter data : Array(Transaction)?
  end
end
