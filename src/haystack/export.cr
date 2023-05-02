struct Haystack::Export
  include Haystack::Resource

  getter path : String

  Haystack.time_field :expires
end
