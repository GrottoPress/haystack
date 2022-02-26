struct Haystack::Subscription::Endpoint
  include Hapi::Endpoint

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

  def enable(**params)
    yield enable(**params)
  end

  def enable(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/enable",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def disable(**params)
    yield disable(**params)
  end

  def disable(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/disable",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "subscription"
    uri
  end
end
