struct Haystack::Metadata
  include Haystack::Resource
  include JSON::Serializable::Unmapped
  include FromAny

  @recurring : ::Bool | Int32 | Nil

  getter any : JSON::Any?
  getter banks : Array(String)?
  getter cancel_action : String?
  getter card_brands : Array(String)?
  getter custom_fields : Array(CustomField)?

  def recurring
    recurring?
  end

  def recurring?
    Bool.from_any(@recurring)
  end

  def self.from_any(metadata) : self?
    case metadata
    when JSON::Any, Bool, Number, String
      from_json({any: metadata}.to_json)
    else
      metadata
    end
  end

  struct CustomField
    include Haystack::Resource

    getter display_name : String
    getter variable_name : String
    getter value : JSON::Any
  end
end
