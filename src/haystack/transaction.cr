struct Haystack::Transaction
  include JSON::Serializable

  getter amount : Int64?
  getter authorization : Card::Authorization?
  getter channel : Channel?
  getter created_at : Time?
  getter createdAt : Time?
  getter currency : Currency?
  getter customer : Customer | Int64 | Nil
  getter domain : Domain?
  getter fees : Int64?
  getter fees_split : Int64?
  getter gateway_response : String?
  getter id : Int64?
  getter ip_address : String?
  getter log : Log?
  getter message : String?
  getter metadata : Metadata | JSON::Any | Nil
  getter order_id : Int64?
  getter paid_at : Time?
  getter paidAt : Time?
  getter plan : Plan | String | Int64 | Nil
  getter plan_object : Plan?
  getter pos_transaction_data : JSON::Any? # Figure out type
  getter reference : String?
  getter requested_amount : Int64?
  getter source : Source?
  getter split : Split?
  getter status : Status?
  getter subaccount : Subaccount?
  getter transaction_date : Time?
end
