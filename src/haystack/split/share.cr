struct Haystack::Split::Share
  include Hapi::Resource

  getter subaccount : Subaccount
  getter share : Int64
end
