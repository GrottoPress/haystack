struct Haystack::Recipient::Details
  include JSON::Serializable

  getter account_name : String?
  getter account_number : String?
  getter authorization_code : String?
  getter bank_code : String?
  getter bank_name : String?
end
