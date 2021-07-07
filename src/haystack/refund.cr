struct Haystack::Refund
  include JSON::Serializable

  getter amount : Int64?
  getter channel : Channel?
  getter createdAt : Time?
  getter currency : Currency?
  getter customer_note : String?
  getter deducted_amount : Int64?
  getter dispute : Int64?
  getter domain : Domain?
  getter expected_at : Time?
  getter fully_deducted : Bool | Int32 | Nil
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter merchant_note : String?
  getter refunded_at : Time?
  getter refunded_by : String?
  getter settlement : Settlement | Int64 | Nil
  getter status : Status?
  getter transaction : Transaction | Int64 | Nil
  getter updatedAt : Time?
end
