struct Haystack::Subaccount::List
  include Response

  struct Resource
    getter data : Array(Subaccount)?
  end
end
