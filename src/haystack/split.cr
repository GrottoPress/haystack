struct Haystack::Split
  include JSON::Serializable

  @active : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil

  getter bearer_subaccount : Int64?
  getter bearer_type : String?
  getter created_at : Time?
  getter currency : Currency?
  getter domain : Domain?
  getter id : Int64?
  getter name : String?
  getter split_code : String?
  getter subaccounts : Array(Share)?
  getter total_subaccounts : Int32?
  getter type : Type?
  getter updated_at : Time?

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
