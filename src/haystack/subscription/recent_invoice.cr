class Haystack::Subscription::RecentInvoice
  include JSON::Serializable

  getter amount : Int64?
  getter authorization : Authorization | Int64 | Nil
  getter created_at : Time?
  getter customer : Customer | Int64 | Nil
  getter description : String?
  getter domain : Domain?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter invoice_code : String?
  getter next_notification : Time?
  getter notification_flag : JSON::Any? # "null" - Figure out type
  getter paid : Int32?
  getter paid_at : Time?
  getter period_end : Time?
  getter period_start : Time?
  getter retries : Int32?
  getter status : Invoice::Status?
  getter subscription : Subscription | Int64 | Nil
  getter transaction : Transaction | Int64 | Nil
  getter updated_at : Time?
end
