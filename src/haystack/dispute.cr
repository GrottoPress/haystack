class Haystack::Dispute
  include Hapi::Resource

  @customer : Customer | Int64 | Nil
  @evidence : Evidence | Int64 | Nil
  @transaction : Transaction | Int64 | Nil

  getter attachments : String?
  getter bin : String?
  getter category : String?
  getter currency : Currency?
  getter domain : Domain?
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
  getter source : Source?
  getter status : Status?
  getter transaction_reference : String?

  Haystack.time_field :created, :due, :resolved, :updated

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def evidence : Evidence?
    Evidence.from_any(@evidence)
  end

  def transaction : Transaction?
    Transaction.from_any(@transaction)
  end
end
