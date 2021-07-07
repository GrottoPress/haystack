struct Haystack::Dispute::Message
  include JSON::Serializable

  getter body : String?
  getter createdAt : Time?
  getter dispute : Dispute | Int64 | Nil
  getter id : Int64?
  getter is_deleted : Bool | Int32 | Nil
  getter sender : String?
  getter updatedAt : Time?
end
