struct Haystack::Subaccount
  include Haystack::Resource

  @active : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @is_verified : ::Bool | Int32 | Nil
  @metadata : Metadata | JSON::Any | Nil
  @migrate : ::Bool | Int32 | Nil

  getter account_number : String?
  getter business_name : String?
  getter description : String?
  getter domain : Domain?
  getter id : Int64?
  getter percentage_charge : Float64?
  getter primary_contact_email : String?
  getter primary_contact_name : String?
  getter primary_contact_phone : String?
  getter settlement_bank : String?
  getter settlement_schedule : Settlement::Schedule?
  getter subaccount_code : String?

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def active
    active?
  end

  def migrate
    migrate?
  end

  def is_verified
    is_verified?
  end

  def active?
    Bool.from_any(@active)
  end

  def migrate?
    Bool.from_any(@migrate)
  end

  def is_verified?
    Bool.from_any(@is_verified)
  end
end
