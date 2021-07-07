struct Haystack::Integration
  include JSON::Serializable

  getter allowed_currencies : Array(Currency)?
  getter key : String?
  getter logo : String?
  getter name : String?
end
