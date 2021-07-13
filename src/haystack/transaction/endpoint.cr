struct Haystack::Transaction::Endpoint
  include Hapi::Endpoint

  def init(**params)
    yield init(**params)
  end

  def init(**params) : Authorization::Item
    @client.post(
      "#{self.class.uri.path}/initialize",
      body: params.to_json
    ) do |response|
      Authorization::Item.from_json(response.body_io)
    end
  end

  def verify(reference : String)
    yield verify(reference)
  end

  def verify(reference : String) : Item
    @client.get("#{self.class.uri.path}/verify/#{reference}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def charge_auth(**params)
    yield charge_auth(**params)
  end

  def charge_auth(**params) : Item
    @client.post(
      "#{self.class.uri.path}/charge_authorization",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def check_auth(**params)
    yield check_auth(**params)
  end

  def check_auth(**params) : Amount::Item
    @client.post(
      "#{self.class.uri.path}/check_authorization",
      body: params.to_json
    ) do |response|
      Amount::Item.from_json(response.body_io)
    end
  end

  def timeline(id : String | Int)
    yield timeline(id)
  end

  def timeline(id : String | Int) : Timeline::Item
    @client.get("#{self.class.uri.path}/timeline/#{id}") do |response|
      Timeline::Item.from_json(response.body_io)
    end
  end

  def totals(**params)
    yield totals(**params)
  end

  def totals(**params) : Totals::Item
    @client.get(
      "#{self.class.uri.path}/totals?#{URI::Params.encode(params)}"
    ) do |response|
      Totals::Item.from_json(response.body_io)
    end
  end

  def export(**params)
    yield export(**params)
  end

  def export(**params) : Export::Item
    @client.get(
      "#{self.class.uri.path}/export?#{URI::Params.encode(params)}"
    ) do |response|
      Export::Item.from_json(response.body_io)
    end
  end

  def debit(**params)
    yield debit(**params)
  end

  def debit(**params) : Item
    @client.post(
      "#{self.class.uri.path}/partial_debit",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transaction"
    uri
  end
end
