struct Haystack::Plan
  include Hapi::Resource
  include FromAny

  @hosted_page : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @is_archived : ::Bool | Int32 | Nil
  @is_deleted : ::Bool | Int32 | Nil
  @migrate : ::Bool | Int32 | Nil
  @send_invoices : ::Bool | Int32 | Nil
  @send_sms : ::Bool | Int32 | Nil

  getter active_subscriptions : Int64?
  getter amount : Int64?
  getter currency : Currency?
  getter description : String?
  getter domain : Domain?
  getter hosted_page_summary : String?
  getter hosted_page_url : String?
  getter id : Int64?
  getter interval : Interval?
  getter invoice_limit : Int32?
  getter name : String?
  getter pages : Array(JSON::Any)? # Figure out type
  getter plan_code : String?
  getter subscriptions : Array(Subscription)?
  getter total_subscriptions : Int64?
  getter total_subscriptions_revenue : Int64?

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def hosted_page
    hosted_page?
  end

  def is_deleted
    is_deleted?
  end

  def is_archived
    is_archived?
  end

  def migrate
    migrate?
  end

  def send_invoices
    send_invoices?
  end

  def send_sms
    send_sms?
  end

  def hosted_page?
    Bool.from_any(@hosted_page)
  end

  def is_deleted?
    Bool.from_any(@is_deleted)
  end

  def is_archived?
    Bool.from_any(@is_archived)
  end

  def migrate?
    Bool.from_any(@migrate)
  end

  def send_invoices?
    Bool.from_any(@send_invoices)
  end

  def send_sms?
    Bool.from_any(@send_sms)
  end

  def self.from_any(plan) : self?
    return from_json(%({"plan_code": "#{plan}"})) if plan.is_a?(String)
    previous_def
  end
end
