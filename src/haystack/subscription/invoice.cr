class Haystack::Subscription::Invoice
  include Hapi::Resource

  @customer : Customer | Int64 | Nil
  @integration : Integration | Int64 | Nil
  @paid : ::Bool | Int32 | Nil
  @subscription : Subscription | Int64 | Nil
  @transaction : Transaction | Int64 | Nil

  getter amount : Int32?
  getter authorization : Card::Authorization?
  getter description : String?
  getter domain : Domain?
  getter id : Int64?
  getter invoice_code : String?
  getter next_notification : Time?
  getter notification_flag : JSON::Any? # Figure out type
  getter period_end : Time?
  getter period_start : Time?
  getter retries : Int32?
  getter status : Haystack::Invoice::Status?

  Haystack.time_field :created, :paid, :updated

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def transaction : Transaction?
    Transaction.from_any(@transaction)
  end

  def subscription : Subscription?
    Subscription.from_any(@subscription)
  end

  def paid
    paid?
  end

  def paid?
    Bool.from_any(@paid)
  end
end
