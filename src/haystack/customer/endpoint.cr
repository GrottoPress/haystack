struct Haystack::Customer::Endpoint
  include Haystack::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    response = @client.post(self.class.uri.path, body: params.to_json)
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

  def fetch(code : String)
    yield fetch(code)
  end

  def fetch(code : String) : Item
    response = @client.get("#{self.class.uri.path}/#{code}")
    Item.from_json(response.body)
  end

  def update(code : String, **params)
    yield update(code, **params)
  end

  def update(code : String, **params) : Item
    response = @client.put(
      "#{self.class.uri.path}/#{code}",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def verify(code : String, **params)
    yield verify(code, **params)
  end

  def verify(code : String, **params) : Identification::Item
    response = @client.post(
      "#{self.class.uri.path}/#{code}/identification",
      body: params.to_json
    )

    Identification::Item.from_json(response.body)
  end

  def set_risk_action(**params)
    yield set_risk_action(**params)
  end

  def set_risk_action(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/set_risk_action",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def deactivate_authorization(**params)
    yield deactivate_authorization(**params)
  end

  def deactivate_authorization(**params) : Card::Authorization::Item
    response = @client.post(
      "#{self.class.uri.path}/deactivate_authorization",
      body: params.to_json
    )

    Card::Authorization::Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "customer"
    uri
  end
end
