struct Haystack::Split::Share
  include Hapi::Resource

  getter subaccount : Subaccount
  getter share : Int32
end
