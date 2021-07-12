struct Haystack::BulkCharge
  include JSON::Serializable

  @integration : Integration | Int64 | Nil

  getter batch_code : String?
  getter createdAt : Time?
  getter domain : Domain?
  getter id : Int64?
  getter pending_charges : Int32?
  getter status : Status?
  getter total_charges : Int32?
  getter updatedAt : Time?

  def integration : Integration?
    Integration.from_any(@integration)
  end
end
