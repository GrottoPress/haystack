struct Haystack::Discount
  include Hapi::Resource

  getter amount : Int32
  getter type : Type
end
