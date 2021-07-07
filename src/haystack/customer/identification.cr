struct Haystack::Customer::Identification
  include JSON::Serializable

  enum Type
    BVN
  end

  getter country : String
  getter type : Type
  getter value : String

  struct Item
    include Response

    getter data : Identification?
  end
end
