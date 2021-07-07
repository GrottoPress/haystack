struct Haystack::Split::Share
  include JSON::Serializable

  getter subaccount : Subaccount
  getter share : Int64
end
