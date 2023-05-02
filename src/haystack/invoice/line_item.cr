struct Haystack::Invoice::LineItem
  include Haystack::Resource

  getter amount : Int32
  getter name : String
end
