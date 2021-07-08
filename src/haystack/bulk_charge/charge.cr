struct Haystack::BulkCharge::Charge
  include JSON::Serializable

  enum Status
    Success
    Pending
    Failed
  end

  getter amount : Int64?
  getter authorization : Card::Authorization?
  getter bulkcharge : Int64?
  getter createdAt : Time?
  getter currency : Currency?
  getter customer : Customer | Int64 | Nil
  getter domain : Domain?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter status : Status?
  getter transaction : Transaction | Int64 | Nil
  getter updatedAt : Time?

  struct List
    include Response

    getter data : Array(Charge)?
  end
end
