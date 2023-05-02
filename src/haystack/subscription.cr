class Haystack::Subscription
  include Haystack::Resource
  include FromAny

  @customer : Customer | Int64 | Nil
  @integration : Integration | Int64 | Nil
  @plan : Plan | String | Int64 | Nil

  getter amount : Int32?
  getter authorization : Card::Authorization?
  getter cron_expression : String?
  getter domain : Domain?
  getter easy_cron_id : String?
  getter email_token : String?
  getter id : Int64?
  getter invoice_limit : Int32?
  getter invoices : Array(Invoice)?
  getter most_recent_invoice : Invoice?
  getter next_payment_date : Time?
  getter open_invoice : String?
  getter payments_count : Int32?
  getter quantity : Int32?
  getter split_code : String?
  getter start : Int64?
  getter status : Status?
  getter subscription_code : String?

  Haystack.time_field :cancelled, :created, :updated

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def plan : Plan?
    Plan.from_any(@plan)
  end
end
