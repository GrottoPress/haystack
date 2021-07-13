struct Haystack::Charge::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Transaction::Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_pin(**params)
    yield submit_pin(**params)
  end

  def submit_pin(**params) : Transaction::Item
    @client.post(
      "#{self.class.uri.path}/submit_pin",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_otp(**params)
    yield submit_otp(**params)
  end

  def submit_otp(**params) : Transaction::Item
    @client.post(
      "#{self.class.uri.path}/submit_otp",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_phone(**params)
    yield submit_phone(**params)
  end

  def submit_phone(**params) : Transaction::Item
    @client.post(
      "#{self.class.uri.path}/submit_phone",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_birthday(**params)
    yield submit_birthday(**params)
  end

  def submit_birthday(**params) : Transaction::Item
    @client.post(
      "#{self.class.uri.path}/submit_birthday",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_address(**params)
    yield submit_address(**params)
  end

  def submit_address(**params) : Transaction::Item
    @client.post(
      "#{self.class.uri.path}/submit_address",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def check_status(reference : String)
    yield check_status(reference)
  end

  def check_status(reference : String) : Transaction::Item
    @client.get("#{self.class.uri.path}/#{reference}") do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "charge"
    uri
  end
end
