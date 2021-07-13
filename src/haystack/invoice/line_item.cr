struct Haystack::Invoice::LineItem
  include Hapi::Resource

  getter amount : Int64
  getter name : String
end
