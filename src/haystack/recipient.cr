struct Haystack::Recipient
  include JSON::Serializable
  include FromAny

  @active : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @is_deleted : ::Bool | Int32 | Nil
  @isDeleted : ::Bool | Int32 | Nil
  @metadata : Metadata | JSON::Any | Nil

  getter createdAt : Time?
  getter currency : Currency?
  getter description : String?
  getter details : Details?
  getter domain : Domain?
  getter email : String?
  getter id : Int64?
  getter name : String?
  getter recipient_code : String?
  getter type : Bank::Type?
  getter updatedAt : Time?

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def active
    active?
  end

  def is_deleted
    is_deleted?
  end

  def isDeleted
    isDeleted?
  end

  def active?
    Bool.from_any(@active)
  end

  def is_deleted?
    Bool.from_any(@is_deleted)
  end

  def isDeleted?
    Bool.from_any(@isDeleted)
  end

  def self.from_any(recipient) : self?
    if recipient.is_a?(String)
      return from_json(%({"recipient_code": "#{recipient}"}))
    end

    previous_def
  end
end
