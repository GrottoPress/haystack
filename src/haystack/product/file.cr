struct Haystack::Product::File
  include Hapi::Resource

  getter key : String
  getter original_filename : String
  getter path : String
  getter type : String
end
