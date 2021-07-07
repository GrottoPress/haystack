class Haystack::Dispute
  include JSON::Serializable

  getter attachments : String?
  getter bin : String?
  getter category : String?
  getter createdAt : Time?
  getter currency : Currency?
  getter customer : Customer | Int64 | Nil
  getter domain : Domain?
  getter dueAt : Time?
  getter evidence : Evidence | Int64 | Nil
  getter history : Array(History)?
  getter id : Int64?
  getter last4 : String?
  getter merchant_transaction_reference : String?
  getter message : Message?
  getter messages : Array(Message)?
  getter note : String?
  getter organization : Int64?
  getter refund_amount : Int64?
  getter resolution : String?
  getter resolvedAt : Time?
  getter source : Source?
  getter status : Status?
  getter transaction : Transaction | Int64 | Nil
  getter transaction_reference : String?
  getter updatedAt : Time?
end
