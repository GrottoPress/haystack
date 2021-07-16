struct Haystack::Export
  include Hapi::Resource

  getter path : String

  Haystack.time_field :expires
end
