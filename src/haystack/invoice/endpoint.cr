struct Haystack::Invoice::Endpoint
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

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Item.from_json(response.body)
  end

  def update(id : String | Int, **params)
    yield update(id, **params)
  end

  def update(id : String | Int, **params) : Item
    response = @client.put(
      "#{self.class.uri.path}/#{id}",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def verify(code : String)
    yield verify(code)
  end

  def verify(code : String) : Item
    response = @client.get("#{self.class.uri.path}/verify/#{code}")
    Item.from_json(response.body)
  end

  def notify(id : String | Int)
    yield notify(id)
  end

  def notify(id : String | Int) : Notification::Item
    response = @client.post("#{self.class.uri.path}/notify/#{id}")
    Notification::Item.from_json(response.body)
  end

  def totals
    yield totals
  end

  def totals : Totals::Item
    response = @client.get("#{self.class.uri.path}/totals")
    Totals::Item.from_json(response.body)
  end

  def finalise(id : String | Int)
    yield finalise(id)
  end

  def finalise(id : String | Int) : Item
    response = @client.post("#{self.class.uri.path}/finalize/#{id}")
    Item.from_json(response.body)
  end

  def archive(id : String | Int)
    yield archive(id)
  end

  def archive(id : String | Int) : Item
    response = @client.post("#{self.class.uri.path}/archive/#{id}")
    Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "paymentrequest"
    uri
  end
end
