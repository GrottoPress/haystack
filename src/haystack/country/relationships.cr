struct Haystack::Country::Relationships
  include JSON::Serializable

  getter currency : Relationship
  getter integration_feature : Relationship
  getter integration_type : Relationship
  getter payment_method : Relationship

  struct Relationship
    include JSON::Serializable

    getter data : Array(String)
    getter type : String
  end
end
