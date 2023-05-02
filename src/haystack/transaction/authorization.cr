struct Haystack::Transaction::Authorization
  include Haystack::Resource

  getter access_code : String
  getter authorization_url : String
  getter reference : String

  struct Item
    include Response

    getter data : Authorization?
  end
end
