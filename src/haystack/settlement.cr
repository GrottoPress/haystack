struct Haystack::Settlement
  include JSON::Serializable

  getter createdAt : Time?
  getter domain : Domain?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter settled_by : JSON::Any? # Figure out type
  getter settlement_date : Time?
  getter status : Status?
  getter subaccount : Subaccount?
  getter total_amount : Int64?
  getter updatedAt : Time?
end
