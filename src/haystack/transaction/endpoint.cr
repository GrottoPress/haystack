struct Haystack::Transaction::Endpoint
  include Hapi::Endpoint

  def initiate(**params)
    yield initiate(**params)
  end

  def initiate(**params) : Authorization::Item
    response = @client.post(
      "#{self.class.uri.path}/initialize",
      body: params.to_json
    )

    Authorization::Item.new(response)
  end

  def verify(reference : String)
    yield verify(reference)
  end

  def verify(reference : String) : Item
    response = @client.get("#{self.class.uri.path}/verify/#{reference}")
    Item.new(response)
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    )

    List.new(response)
  end

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Item.new(response)
  end

  def charge_authorization(**params)
    yield charge_authorization(**params)
  end

  def charge_authorization(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/charge_authorization",
      body: params.to_json
    )

    Item.new(response)
  end

  def check_authorization(**params)
    yield check_authorization(**params)
  end

  def check_authorization(**params) : Amount::Item
    response = @client.post(
      "#{self.class.uri.path}/check_authorization",
      body: params.to_json
    )

    Amount::Item.new(response)
  end

  def timeline(id : String | Int)
    yield timeline(id)
  end

  def timeline(id : String | Int) : Timeline::Item
    response = @client.get("#{self.class.uri.path}/timeline/#{id}")
    Timeline::Item.new(response)
  end

  def totals(**params)
    yield totals(**params)
  end

  def totals(**params) : Totals::Item
    response = @client.get(
      "#{self.class.uri.path}/totals?#{URI::Params.encode(params)}"
    )

    Totals::Item.new(response)
  end

  def export(**params)
    yield export(**params)
  end

  def export(**params) : Export::Item
    response = @client.get(
      "#{self.class.uri.path}/export?#{URI::Params.encode(params)}"
    )

    Export::Item.new(response)
  end

  def debit(**params)
    yield debit(**params)
  end

  def debit(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/partial_debit",
      body: params.to_json
    )

    Item.new(response)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transaction"
    uri
  end
end
