struct Haystack::Charge::Endpoint
  def initialize(@haystack : Haystack)
  end

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Transaction::Item
    @haystack.post(self.class.path, body: params.to_json) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_pin(**params)
    yield submit_pin(**params)
  end

  def submit_pin(**params) : Transaction::Item
    @haystack.post(
      "#{self.class.path}/submit_pin",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_otp(**params)
    yield submit_otp(**params)
  end

  def submit_otp(**params) : Transaction::Item
    @haystack.post(
      "#{self.class.path}/submit_otp",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_phone(**params)
    yield submit_phone(**params)
  end

  def submit_phone(**params) : Transaction::Item
    @haystack.post(
      "#{self.class.path}/submit_phone",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_birthday(**params)
    yield submit_birthday(**params)
  end

  def submit_birthday(**params) : Transaction::Item
    @haystack.post(
      "#{self.class.path}/submit_birthday",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def submit_address(**params)
    yield submit_address(**params)
  end

  def submit_address(**params) : Transaction::Item
    @haystack.post(
      "#{self.class.path}/submit_address",
      body: params.to_json
    ) do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def check_status(reference : String)
    yield check_status(reference)
  end

  def check_status(reference : String) : Transaction::Item
    @haystack.get("#{self.class.path}/#{reference}") do |response|
      Transaction::Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}charge"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
