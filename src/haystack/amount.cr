struct Haystack::Amount
  include Haystack::Resource

  getter amount : Int64
  getter currency : Currency
end
