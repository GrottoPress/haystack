class Haystack::Subscription
  include JSON::Serializable

  getter amount : Int64?
  getter authorization : Authorization?
  getter cancelledAt : Time?
  getter createdAt : Time?
  getter cron_expression : String?
  getter customer : Customer | Int64 | Nil
  getter domain : Domain?
  getter easy_cron_id : String?
  getter email_token : String?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter invoice_limit : Int32?
  getter invoices : Array(Invoice)?
  getter most_recent_invoice : RecentInvoice?
  getter next_payment_date : Time?
  getter open_invoice : String?
  getter payments_count : Int32?
  getter plan : Plan | String | Int64 | Nil
  getter quantity : Int32?
  getter split_code : String?
  getter start : Int64?
  getter status : Status?
  getter subscription_code : String?
  getter updatedAt : Time?
end
