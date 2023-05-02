struct Haystack::Transaction
  include Haystack::Resource
  include FromAny

  @customer : Customer | Int64 | Nil
  @metadata : Metadata | JSON::Any | Nil
  @plan : Plan | String | Int64 | Nil

  getter amount : Int32?
  getter authorization : Card::Authorization?
  getter channel : Channel?
  getter currency : Currency?
  getter domain : Domain?
  getter fees : Int32?
  getter fees_split : Int32?
  getter gateway_response : String?
  getter id : Int64?
  getter ip_address : String?
  getter log : Log?
  getter message : String?
  getter order_id : Int64?
  getter plan_object : Plan?
  getter pos_transaction_data : JSON::Any? # Figure out type
  getter reference : String?
  getter requested_amount : Int32?
  getter source : Source?
  getter split : Split?
  getter status : Status?
  getter subaccount : Subaccount?
  getter transaction_date : Time?

  Haystack.time_field :created, :paid

  # These are for when checking pending charges
  getter display_text : String?
  getter url : String?

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def plan : Plan?
    Plan.from_any(@plan)
  end
end
