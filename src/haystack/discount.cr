struct Haystack::Discount
  include Haystack::Resource

  getter amount : Int32
  getter type : Type
end
