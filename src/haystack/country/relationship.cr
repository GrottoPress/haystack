struct Haystack::Country::Relationship
  include Haystack::Resource

  getter data : Array(String)
  getter type : String
end
