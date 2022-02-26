struct Haystack::Subaccount::Item
  include Response

  struct Resource
    getter data : Subaccount?
  end
end
