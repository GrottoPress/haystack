struct Haystack::Customer::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
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

  def fetch(code : String)
    yield fetch(code)
  end

  def fetch(code : String) : Item
    @client.get("#{self.class.uri.path}/#{code}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(code : String, **params)
    yield update(code, **params)
  end

  def update(code : String, **params) : Item
    @client.put(
      "#{self.class.uri.path}/#{code}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def verify(code : String, **params)
    yield verify(code, **params)
  end

  def verify(code : String, **params) : Identification::Item
    @client.post(
      "#{self.class.uri.path}/#{code}/identification",
      body: params.to_json
    ) do |response|
      Identification::Item.from_json(response.body_io)
    end
  end

  def set_risk_action(**params)
    yield set_risk_action(**params)
  end

  def set_risk_action(**params) : Item
    @client.post(
      "#{self.class.uri.path}/set_risk_action",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def deactivate_auth(**params)
    yield deactivate_auth(**params)
  end

  def deactivate_auth(**params) : Card::Authorization::Item
    @client.post(
      "#{self.class.uri.path}/deactivate_authorization",
      body: params.to_json
    ) do |response|
      Card::Authorization::Item.from_json(response.body_io)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "customer"
    uri
  end
end
