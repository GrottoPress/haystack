class Haystack::Customer
  include JSON::Serializable

  getter authorizations : Array(Card::Authorization)?
  getter createdAt : Time?
  getter customer_code : String?
  getter dedicated_account : Bank::Account?
  getter domain : Domain?
  getter email : String?
  getter first_name : String?
  getter id : Int64?
  getter identified : Bool | Int32 | Nil
  getter identifications : Array(Identification)?
  getter integration : Integration | Int64 | Nil
  getter international_format_phone : String?
  getter last_name : String?
  getter metadata : Metadata | JSON::Any | Nil
  getter phone : String?
  getter risk_action : RiskAction?
  getter subscriptions : Array(Subscription)?
  getter transactions : Array(Transaction)?
  getter updatedAt : Time?
end
