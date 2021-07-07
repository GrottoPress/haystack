struct Haystack::Bank::Verification
  include JSON::Serializable

  getter account_name : String
  getter account_number : String
  getter bank_id : Int32

  struct Item
    include Response

    getter data : Verification?
  end
end
