struct Haystack::Recipient
  include JSON::Serializable

  getter active : Bool | Int32 | Nil
  getter createdAt : Time?
  getter currency : Currency?
  getter description : String?
  getter details : Details?
  getter domain : Domain?
  getter email : String?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter is_deleted : Bool | Int32 | Nil
  getter isDeleted : Bool | Int32 | Nil
  getter metadata : Metadata | JSON::Any | Nil
  getter name : String?
  getter recipient_code : String?
  getter type : Bank::Type?
  getter updatedAt : Time?
end
