struct Haystack::Card::Authorization
  include JSON::Serializable

  @reusable : ::Bool | Int32 | Nil

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
  getter signature : String?

  def reusable
    reusable?
  end

  def reusable?
    Bool.from_any(@reusable)
  end

  struct Item
    include Response

    getter data : Authorization?
  end

end
