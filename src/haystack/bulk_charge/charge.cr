struct Haystack::BulkCharge::Charge
  include Hapi::Resource

  enum Status
    Success
    Pending
    Failed
  end

  @customer : Customer | Int64 | Nil
  @integration : Integration | Int64 | Nil
  @transaction : Transaction | Int64 | Nil

  getter amount : Int64?
  getter authorization : Card::Authorization?
  getter bulkcharge : Int64?
  getter createdAt : Time?
  getter currency : Currency?
  getter domain : Domain?
  getter id : Int64?
  getter status : Status?
  getter updatedAt : Time?

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def transaction : Transaction?
    Transaction.from_any(@transaction)
  end

  struct List
    include Response

    getter data : Array(Charge)?
  end
end
