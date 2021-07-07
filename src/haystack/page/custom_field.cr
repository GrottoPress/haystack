struct Haystack::Page::CustomField
  include JSON::Serializable

  getter display_name : String
  getter variable_name : String
end
