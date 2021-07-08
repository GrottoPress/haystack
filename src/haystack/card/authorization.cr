struct Haystack::Card::Authorization
  include JSON::Serializable

  getter account_name : String?
  getter authorization_code : String?
  getter bank : String?
  getter bin : String?
  getter brand : String?
  getter card_type : String?
  getter channel : Channel?
  getter country_code : String?
  getter exp_month : String?
  getter exp_year : String?
  getter last4 : String?
  getter receiver_bank : String?
  getter receiver_bank_account_number : String?
  getter reusable : Bool | Int32 | Nil
  getter signature : String?

  struct Item
    include Response

    getter data : Authorization?
  end

end
