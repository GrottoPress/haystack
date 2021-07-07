struct Haystack::Discount
  include JSON::Serializable

  getter amount : Int64
  getter type : Type
end
