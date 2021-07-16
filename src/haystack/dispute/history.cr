struct Haystack::Dispute::History
  include Hapi::Resource

  @dispute : Dispute | Int64 | Nil

  getter by : String?
  getter id : Int64?
  getter status : Status?

  Haystack.time_field :created, :updated

  def dispute : Dispute?
    Dispute.from_any(@dispute)
  end
end
