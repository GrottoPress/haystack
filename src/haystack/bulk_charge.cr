struct Haystack::BulkCharge
  include JSON::Serializable

  getter batch_code : String?
  getter createdAt : Time?
  getter domain : Domain?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter pending_charges : Int32?
  getter status : Status?
  getter total_charges : Int32?
  getter updatedAt : Time?
end
