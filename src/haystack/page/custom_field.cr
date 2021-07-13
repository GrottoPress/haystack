struct Haystack::Page::CustomField
  include Hapi::Resource

  getter display_name : String
  getter variable_name : String
end
