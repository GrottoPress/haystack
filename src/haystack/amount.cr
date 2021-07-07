struct Haystack::Amount
  include JSON::Serializable

  getter amount : Int64
  getter currency : Currency
end
