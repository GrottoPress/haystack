struct Haystack::Product::File
  include JSON::Serializable

  getter key : String
  getter original_filename : String
  getter path : String
  getter type : String
end
