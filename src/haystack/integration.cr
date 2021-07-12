struct Haystack::Integration
  include JSON::Serializable
  include FromAny

  getter allowed_currencies : Array(Currency)?
  getter id : Int64?
  getter key : String?
  getter logo : String?
  getter name : String?
end
