struct Haystack::Page::CustomField
  include Haystack::Resource

  getter display_name : String
  getter variable_name : String
end
