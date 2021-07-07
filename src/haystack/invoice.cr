struct Haystack::Invoice
  include JSON::Serializable

  getter amount : Int64?
  getter amount_paid : Int64?
  getter archived : Bool | Int32 | Nil
  getter createdAt : Time?
  getter created_at : Time?
  getter currency : Currency?
  getter customer : Customer | Int64 | Nil
  getter description : String?
  getter discount : Discount?
  getter domain : Domain?
  getter due_date : Time?
  getter has_invoice : Bool | Int32 | Nil
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter invoice_number : Int64?
  getter line_items : Array(LineItem)?
  getter metadata : Metadata | JSON::Any | Nil
  getter note : String?
  getter notifications : Array(Notification)?
  getter offline_reference : String?
  getter pending_amount : Int64?
  getter paid : Bool | Int32 | Nil
  getter paid_at : Time?
  getter payment_method : String?
  getter pdf_url : String?
  getter request_code : String?
  getter source : Source?
  getter status : Status?
  getter tax : Array(Tax)?
  getter transactions : Array(Transaction)?
  getter updatedAt : Time?
  getter updated_at : Time?
end
