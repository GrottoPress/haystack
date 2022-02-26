struct Haystack::Transfer::Endpoint
  include Hapi::Endpoint

  def initiate(**params)
    yield initiate(**params)
  end

  def initiate(**params) : Item
    response = @client.post(self.class.uri.path, body: params.to_json)
    Item.from_json(response.body)
  end

  def initiate(transfers : Array(NamedTuple), **params)
    yield initiate(transfers, **params)
  end

  def initiate(transfers : Array(NamedTuple), **params) : List
    response = @client.post(
      "#{self.class.uri.path}/bulk",
      body: params.merge({transfers: transfers}).to_json
    )

    List.from_json(response.body)
  end

  def finalise(**params)
    yield finalise(**params)
  end

  def finalise(**params) : Item
    response = @client.post(
      "#{self.class.uri.path}/finalize_transfer",
      body: params.to_json
    )

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

  def verify(reference : String)
    yield verify(reference)
  end

  def verify(reference : String) : Item
    response = @client.get("#{self.class.uri.path}/verify/#{reference}")
    Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transfer"
    uri
  end
end
