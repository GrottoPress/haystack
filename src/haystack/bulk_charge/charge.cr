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

  getter amount : Int32?
  getter authorization : Card::Authorization?
  getter bulkcharge : Int64?
  getter currency : Currency?
  getter domain : Domain?
  getter id : Int64?
  getter status : Status?

  Haystack.time_field :created, :updated

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

    struct Resource
      getter data : Array(Charge)?
    end
  end
end
