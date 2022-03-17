struct Haystack::Bank
  include Hapi::Resource

  @active : ::Bool | Int32 | Nil
  @is_deleted : ::Bool | Int32 | Nil
  @pay_with_bank : ::Bool | Int32 | Nil

  getter code : String?
  getter country : String?
  getter currency : Currency?
  getter gateway : Gateway?
  getter id : Int64?
  getter longcode : String?
  getter name : String?
  getter slug : String?
  getter type : Type?

  Haystack.time_field :created, :updated

  def active
    active?
  end

  def is_deleted
    is_deleted?
  end

  def pay_with_bank
    pay_with_bank?
  end

  def active?
    Bool.from_any(@active)
  end

  def deleted?
    is_deleted?
  end

  def is_deleted?
    Bool.from_any(@is_deleted)
  end

  def pay_with_bank?
    Bool.from_any(@pay_with_bank)
  end
end
