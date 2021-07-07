struct Haystack::Metadata
  include JSON::Serializable
  include JSON::Serializable::Unmapped

  getter banks : Array(String)?
  getter cancel_action : String?
  getter card_brands : Array(String)?
  getter custom_fields : Array(CustomField)?
  getter recurring : Bool | Int32 | Nil

  struct CustomField
    include JSON::Serializable

    getter display_name : String
    getter variable_name : String
    getter value : JSON::Any
  end
end
