struct Haystack::Invoice
  include JSON::Serializable

  @archived : ::Bool | Int32 | Nil
  @customer : Customer | Int64 | Nil
  @has_invoice : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @metadata : Metadata | JSON::Any | Nil
  @paid : ::Bool | Int32 | Nil

  getter amount : Int64?
  getter amount_paid : Int64?
  getter createdAt : Time?
  getter created_at : Time?
  getter currency : Currency?
  getter description : String?
  getter discount : Discount?
  getter domain : Domain?
  getter due_date : Time?
  getter id : Int64?
  getter invoice_number : Int64?
  getter line_items : Array(LineItem)?
  getter note : String?
  getter notifications : Array(Notification)?
  getter offline_reference : String?
  getter pending_amount : Int64?
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
