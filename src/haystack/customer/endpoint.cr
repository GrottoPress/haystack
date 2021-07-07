struct Haystack::Customer::Endpoint
  def initialize(@haystack : Haystack)
  end

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @haystack.post(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    @haystack.get(
      "#{self.class.path}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def fetch(code : String)
    yield fetch(code)
  end

  def fetch(code : String) : Item
    @haystack.get("#{self.class.path}/#{code}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(code : String, **params)
    yield update(code, **params)
  end

  def update(code : String, **params) : Item
    @haystack.put(
      "#{self.class.path}/#{code}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def verify(code : String, **params)
    yield verify(code, **params)
  end

  def verify(code : String, **params) : Identification::Item
    @haystack.post(
      "#{self.class.path}/#{code}/identification",
      body: params.to_json
    ) do |response|
      Identification::Item.from_json(response.body_io)
    end
  end

  def set_risk_action(**params)
    yield set_risk_action(**params)
  end

  def set_risk_action(**params) : Item
    @haystack.post(
      "#{self.class.path}/set_risk_action",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def deactivate_auth(**params)
    yield deactivate_auth(**params)
  end

  def deactivate_auth(**params) : Authorization::Item
    @haystack.post(
      "#{self.class.path}/deactivate_authorization",
      body: params.to_json
    ) do |response|
      Authorization::Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}customer"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
