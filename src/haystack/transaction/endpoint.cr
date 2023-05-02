struct Haystack::Transaction::Endpoint
  include Haystack::Endpoint

  def initiate(**params)
    yield initiate(**params)
  end

  def initiate(**params) : Authorization::Item
    response = @client.post(
      "#{self.class.uri.path}/initialize",
      body: params.to_json
    )

    Authorization::Item.from_json(response.body)
  end

  def verify(reference : String)
    yield verify(reference)
  end

  def verify(reference : String) : Item
    response = @client.get("#{self.class.uri.path}/verify/#{reference}")
    Item.from_json(response.body)
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    )

    List.from_json(response.body)
  end

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Item.from_json(response.body)
  end

  def charge_authorization(**params)
    yield charge_authorization(**params)
  end

  def charge_authorization(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/charge_authorization",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def check_authorization(**params)
    yield check_authorization(**params)
  end

  def check_authorization(**params) : Amount::Item
    response = @client.post(
      "#{self.class.uri.path}/check_authorization",
      body: params.to_json
    )

    Amount::Item.from_json(response.body)
  end

  def timeline(id : String | Int)
    yield timeline(id)
  end

  def timeline(id : String | Int) : Timeline::Item
    response = @client.get("#{self.class.uri.path}/timeline/#{id}")
    Timeline::Item.from_json(response.body)
  end

  def totals(**params)
    yield totals(**params)
  end

  def totals(**params) : Totals::Item
    response = @client.get(
      "#{self.class.uri.path}/totals?#{URI::Params.encode(params)}"
    )

    Totals::Item.from_json(response.body)
  end

  def export(**params)
    yield export(**params)
  end

  def export(**params) : Export::Item
    response = @client.get(
      "#{self.class.uri.path}/export?#{URI::Params.encode(params)}"
    )

    Export::Item.from_json(response.body)
  end

  def debit(**params)
    yield debit(**params)
  end

  def debit(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/partial_debit",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transaction"
    uri
  end
end
