struct Haystack::Invoice::LineItem
  include JSON::Serializable

  getter amount : Int64
  getter name : String
end
