struct Haystack::Dispute::History
  include JSON::Serializable

  @dispute : Dispute | Int64 | Nil

  getter by : String?
  getter createdAt : Time?
  getter id : Int64?
  getter status : Status?
  getter updatedAt : Time?

  def dispute : Dispute?
    Dispute.from_any(@dispute)
  end
end
