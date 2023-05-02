struct Haystack::Webhook
  include Haystack::Resource

  @data : JSON::Any
  @event : String

  def data
    case
    when event.charge.dispute?
      Dispute.from_json(@data.to_json)
    when event.charge?
      Transaction.from_json(@data.to_json)
    when event.customeridentification?
      CustomerIdentification.from_json(@data.to_json)
    when event.invoice?
      Subscription::Invoice.from_json(@data.to_json)
    when event.paymentrequest?
      Invoice.from_json(@data.to_json)
    when event.subscription?
      Subscription.from_json(@data.to_json)
    when event.transfer?
      Transfer.from_json(@data.to_json)
    end
  end

  def event : Event
    Event.new(@event)
  end

  struct CustomerIdentification
    include Haystack::Resource

    getter customer_code : String
    getter customer_id : String
    getter email : String
    getter identification : Customer::Identification
  end
end
