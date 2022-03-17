struct Haystack::Dispute::Message
  include Hapi::Resource

  @dispute : Dispute | Int64 | Nil
  @is_deleted : ::Bool | Int32 | Nil

  getter body : String?
  getter id : Int64?
  getter sender : String?

  Haystack.time_field :created, :updated

  def dispute : Dispute?
    Dispute.from_any(@dispute)
  end

  def deleted?
    is_deleted?
  end

  def is_deleted
    is_deleted?
  end

  def is_deleted?
    Bool.from_any(@is_deleted)
  end
end
