struct Haystack::Split::Share
  include Haystack::Resource

  getter subaccount : Subaccount
  getter share : Int32
end
