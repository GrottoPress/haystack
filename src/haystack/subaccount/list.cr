struct Haystack::Subaccount::List
  include Response

  getter data : Array(Subaccount)?
end
