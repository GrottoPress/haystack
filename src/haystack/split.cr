struct Haystack::Split
  include Hapi::Resource

  @active : ::Bool | Int32 | Nil
  @bearer_type : String?
  @integration : Integration | Int64 | Nil

  getter bearer_subaccount : Int64?
  getter currency : Currency?
  getter domain : Domain?
  getter id : Int64?
  getter name : String?
  getter split_code : String?
  getter subaccounts : Array(Share)?
  getter total_subaccounts : Int32?
  getter type : Type?

  Haystack.time_field :created, :updated

  def bearer_type : BearerType?
    @bearer_type.try { |type| BearerType.parse(type.gsub '-', '_') }
  end

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def active
    active?
  end

  def active?
    Bool.from_any(@active)
  end
end
