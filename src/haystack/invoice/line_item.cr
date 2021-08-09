struct Haystack::Invoice::LineItem
  include Hapi::Resource

  getter amount : Int32
  getter name : String
end
