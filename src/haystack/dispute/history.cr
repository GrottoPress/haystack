struct Haystack::Dispute::History
  include JSON::Serializable

  getter by : String?
  getter createdAt : Time?
  getter dispute : Dispute | Int64 | Nil
  getter id : Int64?
  getter status : Status?
  getter updatedAt : Time?
end
