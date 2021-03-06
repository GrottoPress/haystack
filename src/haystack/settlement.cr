struct Haystack::Settlement
  include Hapi::Resource
  include FromAny

  @integration : Integration | Int64 | Nil

  getter domain : Domain?
  getter id : Int64?
  getter settled_by : JSON::Any? # Figure out type
  getter settlement_date : Time?
  getter status : Status?
  getter subaccount : Subaccount?
  getter total_amount : Int32?

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end
end
