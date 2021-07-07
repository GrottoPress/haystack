struct Haystack::Tax
  include JSON::Serializable

  getter amount : Int64
  getter name : String
end
