struct Haystack::Refund
  include Hapi::Resource

  @dispute : Dispute | Int64 | Nil
  @fully_deducted : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @settlement : Settlement | Int64 | Nil
  @transaction : Transaction | Int64 | Nil

  getter amount : Int64?
  getter channel : Channel?
  getter createdAt : Time?
  getter currency : Currency?
  getter customer_note : String?
  getter deducted_amount : Int64?
  getter domain : Domain?
  getter expected_at : Time?
  getter id : Int64?
  getter merchant_note : String?
  getter refunded_at : Time?
  getter refunded_by : String?
  getter status : Status?
  getter updatedAt : Time?

  def dispute : Dispute?
    Dispute.from_any(@dispute)
  end

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def settlement : Settlement?
    Settlement.from_any(@settlement)
  end

  def transaction : Transaction?
    Transaction.from_any(@transaction)
  end

  def fully_deducted
    fully_deducted?
  end

  def fully_deducted?
    Bool.from_any(@fully_deducted)
  end
end
