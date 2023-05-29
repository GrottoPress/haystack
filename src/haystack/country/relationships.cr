struct Haystack::Country::Relationships
  include Haystack::Resource

  getter currency : Relationship
  getter integration_feature : Relationship
  getter integration_type : Relationship
  getter payment_method : Relationship
end
