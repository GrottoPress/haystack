struct Haystack::Product::File
  include Haystack::Resource

  getter key : String
  getter original_filename : String
  getter path : String
  getter type : String
end
