struct Haystack::Transaction::Initialization
  include JSON::Serializable

  getter access_code : String
  getter authorization_url : String
  getter reference : String

  struct Item
    include Response

    getter data : Initialization?
  end

end
