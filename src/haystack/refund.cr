struct Haystack::Refund
  include Haystack::Resource

  @dispute : Dispute | Int64 | Nil
  @fully_deducted : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @settlement : Settlement | Int64 | Nil
  @transaction : Transaction | Int64 | Nil

  getter amount : Int32?
  getter channel : Channel?
  getter currency : Currency?
  getter customer_note : String?
  getter deducted_amount : Int32?
  getter domain : Domain?
  getter id : Int64?
  getter merchant_note : String?
  getter refunded_by : String?
  getter status : Status?

  Haystack.time_field :created, :expected, :refunded, :updated

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
