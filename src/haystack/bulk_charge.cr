struct Haystack::BulkCharge
  include Hapi::Resource

  @integration : Integration | Int64 | Nil

  getter batch_code : String?
  getter domain : Domain?
  getter id : Int64?
  getter pending_charges : Int32?
  getter status : Status?
  getter total_charges : Int32?

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end
end
