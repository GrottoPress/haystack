struct Haystack::Discount
  include Hapi::Resource

  getter amount : Int64
  getter type : Type
end
