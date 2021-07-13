struct Haystack::Amount
  include Hapi::Resource

  getter amount : Int64
  getter currency : Currency
end
