struct Haystack::Export
  include JSON::Serializable

  getter path : String
  getter expiresAt : Time?
end
