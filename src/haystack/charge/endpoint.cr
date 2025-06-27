struct Haystack::Charge::Endpoint
  include Haystack::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Transaction::Item
    response = @client.post(self.class.uri.path, body: params.to_json)
    Transaction::Item.from_json(response.body)
  end

  def submit_pin(**params)
    yield submit_pin(**params)
  end

  def submit_pin(**params) : Transaction::Item
    response = @client.post(
      "#{self.class.uri.path}/submit_pin",
      body: params.to_json
    )

    Transaction::Item.from_json(response.body)
  end

  def submit_otp(**params)
    yield submit_otp(**params)
  end

  def submit_otp(**params) : Transaction::Item
    response = @client.post(
      "#{self.class.uri.path}/submit_otp",
      body: params.to_json
    )

    Transaction::Item.from_json(response.body)
  end

  def submit_phone(**params)
    yield submit_phone(**params)
  end

  def submit_phone(**params) : Transaction::Item
    response = @client.post(
      "#{self.class.uri.path}/submit_phone",
      body: params.to_json
    )

    Transaction::Item.from_json(response.body)
  end

  def submit_birthday(**params)
    yield submit_birthday(**params)
  end

  def submit_birthday(**params) : Transaction::Item
    response = @client.post(
      "#{self.class.uri.path}/submit_birthday",
      body: params.to_json
    )

    Transaction::Item.from_json(response.body)
  end

  def submit_address(**params)
    yield submit_address(**params)
  end

  def submit_address(**params) : Transaction::Item
    response = @client.post(
      "#{self.class.uri.path}/submit_address",
      body: params.to_json
    )

    Transaction::Item.from_json(response.body)
  end

  def check_status(reference : String)
    yield check_status(reference)
  end

  def check_status(reference : String) : Transaction::Item
    response = @client.get("#{self.class.uri.path}/#{reference}")
    Transaction::Item.from_json(response.body)
  end

  def self.uri : URI
    Haystack.uri.tap do |uri|
      uri.path += "charge"
    end
  end
end
