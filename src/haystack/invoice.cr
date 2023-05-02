struct Haystack::Invoice
  include Haystack::Resource

  @archived : ::Bool | Int32 | Nil
  @customer : Customer | Int64 | Nil
  @has_invoice : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @metadata : Metadata | JSON::Any | Nil
  @paid : ::Bool | Int32 | Nil

  getter amount : Int32?
  getter amount_paid : Int32?
  getter currency : Currency?
  getter description : String?
  getter discount : Discount?
  getter domain : Domain?
  getter due_date : Time?
  getter id : Int64?
  getter invoice_number : Int32?
  getter line_items : Array(LineItem)?
  getter note : String?
  getter notifications : Array(Notification)?
  getter offline_reference : String?
  getter pending_amount : Int32?
  getter payment_method : String?
  getter pdf_url : String?
  getter request_code : String?
  getter source : Source?
  getter status : Status?
  getter tax : Array(Tax)?
  getter transactions : Array(Transaction)?

  Haystack.time_field :created, :paid, :updated

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def archived
    archived?
  end

  def has_invoice
    has_invoice?
  end

  def paid
    paid?
  end

  def archived?
    Bool.from_any(@archived)
  end

  def has_invoice?
    Bool.from_any(@has_invoice)
  end

  def paid?
    Bool.from_any(@paid)
  end
end
