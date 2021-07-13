struct Haystack::Tax
  include Hapi::Resource

  getter amount : Int64
  getter name : String
end
