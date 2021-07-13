struct Haystack::Bank::Provider
  include Hapi::Resource

  getter bank_id : Int64
  getter bank_name : String
  getter id : Int64
  getter provider_slug : String

  struct List
    include Response

    getter data : Array(Provider)?
  end
end
