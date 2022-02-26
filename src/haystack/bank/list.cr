struct Haystack::Bank::List
  include Response

  struct Resource
    getter data : Array(Bank)?
  end
end
