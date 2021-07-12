struct Haystack::Dispute::Message
  include JSON::Serializable

  @dispute : Dispute | Int64 | Nil
  @is_deleted : ::Bool | Int32 | Nil

  getter body : String?
  getter createdAt : Time?
  getter id : Int64?
  getter sender : String?
  getter updatedAt : Time?

  def dispute : Dispute?
    Dispute.from_any(@dispute)
  end

  def is_deleted
    is_deleted?
  end

  def is_deleted?
    Bool.from_any(@is_deleted)
  end
end
