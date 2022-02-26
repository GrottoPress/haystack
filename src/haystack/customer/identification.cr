struct Haystack::Customer::Identification
  include Hapi::Resource

  enum Type
    BVN
  end

  getter country : String
  getter type : Type
  getter value : String

  struct Item
    include Response

    struct Resource
      getter data : Identification?
    end
  end
end
