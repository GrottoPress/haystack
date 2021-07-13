struct Haystack::Country::Relationships
  include Hapi::Resource

  getter currency : Relationship
  getter integration_feature : Relationship
  getter integration_type : Relationship
  getter payment_method : Relationship

  struct Relationship
    include Hapi::Resource

    getter data : Array(String)
    getter type : String
  end
end
