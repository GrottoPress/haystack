struct Haystack::Recipient::Details
  include Haystack::Resource

  getter account_name : String?
  getter account_number : String?
  getter authorization_code : String?
  getter bank_code : String?
  getter bank_name : String?
end
