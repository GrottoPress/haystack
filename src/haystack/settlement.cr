struct Haystack::Settlement
  include JSON::Serializable
  include FromAny

  @integration : Integration | Int64 | Nil

  getter createdAt : Time?
  getter domain : Domain?
  getter id : Int64?
  getter settled_by : JSON::Any? # Figure out type
  getter settlement_date : Time?
  getter status : Status?
  getter subaccount : Subaccount?
  getter total_amount : Int64?
  getter updatedAt : Time?

  def integration : Integration?
    Integration.from_any(@integration)
  end
end
