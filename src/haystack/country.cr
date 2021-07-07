struct Haystack::Country
  include JSON::Serializable

  getter active_for_dashboard_onboarding : Bool | Int32 | Nil
  getter calling_code : String?
  getter default_currency_code : Currency?
  getter id : Int64?
  getter integration_defaults : JSON::Any? # TODO: Figure type out
  getter iso_code : String?
  getter name : String?
  getter relationships : Relationships?
end
