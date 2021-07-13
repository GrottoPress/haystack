struct Haystack::Export
  include Hapi::Resource

  getter path : String
  getter expiresAt : Time?
end
