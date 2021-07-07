struct Haystack::Plan
  include JSON::Serializable

  getter active_subscriptions : Int64?
  getter amount : Int64?
  getter createdAt : Time?
  getter currency : Currency?
  getter description : String?
  getter domain : Domain?
  getter hosted_page : Bool | Int32 | Nil
  getter hosted_page_summary : String?
  getter hosted_page_url : String?
  getter id : Int64?
  getter interval : Interval?
  getter integration : Integration | Int64 | Nil
  getter invoice_limit : Int32?
  getter is_deleted : Bool | Int32 | Nil
  getter is_archived : Bool | Int32 | Nil
  getter migrate : Bool | Int32 | Nil
  getter name : String?
  getter pages : Array(JSON::Any)? # Figure out type
  getter plan_code : String?
  getter send_invoices : Bool | Int32 | Nil
  getter send_sms : Bool | Int32 | Nil
  getter subscriptions : Array(Subscription)?
  getter total_subscriptions : Int64?
  getter total_subscriptions_revenue : Int64?
  getter updatedAt : String?
end
