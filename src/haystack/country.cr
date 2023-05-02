struct Haystack::Country
  include Haystack::Resource

  @active_for_dashboard_onboarding : ::Bool | Int32 | Nil

  getter calling_code : String?
  getter default_currency_code : Currency?
  getter id : Int64?
  getter integration_defaults : JSON::Any? # TODO: Figure type out
  getter iso_code : String?
  getter name : String?
  getter relationships : Relationships?

  def active_for_dashboard_onboarding
    active_for_dashboard_onboarding?
  end

  def active_for_dashboard_onboarding?
    Bool.from_any(@active_for_dashboard_onboarding)
  end
end
