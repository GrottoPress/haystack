require "./from_any"

class Haystack::Customer
  include Hapi::Resource
  include FromAny

  @identified : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @metadata : Metadata | JSON::Any | Nil

  getter authorizations : Array(Card::Authorization)?
  getter customer_code : String?
  getter dedicated_account : Bank::Account?
  getter domain : Domain?
  getter email : String?
  getter first_name : String?
  getter id : Int64?
  getter identifications : Array(Identification)?
  getter international_format_phone : String?
  getter last_name : String?
  getter phone : String?
  getter risk_action : RiskAction?
  getter subscriptions : Array(Subscription)?
  getter transactions : Array(Transaction)?

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def identified
    identified?
  end

  def identified?
    Bool.from_any(@identified)
  end
end
