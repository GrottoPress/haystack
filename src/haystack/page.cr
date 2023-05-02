struct Haystack::Page
  include Haystack::Resource

  @active : ::Bool | Int32 | Nil
  @collect_phone : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @metadata : Metadata | JSON::Any | Nil
  @migrate : ::Bool | Int32 | Nil
  @plan : Plan | String | Int64 | Nil
  @published : ::Bool | Int32 | Nil

  getter amount : Int32?
  getter currency : Currency?
  getter custom_fields : Array(CustomField)?
  getter description : String?
  getter domain : Domain?
  getter id : Int64?
  getter name : String?
  getter notification_email : String?
  getter products : Array(Product)?
  getter redirect_url : String?
  getter slug : String?
  getter split_code : String?
  getter success_message : String?
  getter type : Type?

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def plan : Plan?
    Plan.from_any(@plan)
  end

  def active
    active?
  end

  def collect_phone
    collect_phone?
  end

  def migrate
    migrate?
  end

  def published
    published?
  end

  def active?
    Bool.from_any(@active)
  end

  def collect_phone?
    Bool.from_any(@collect_phone)
  end

  def migrate?
    Bool.from_any(@migrate)
  end

  def published?
    Bool.from_any(@published)
  end
end
