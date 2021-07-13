struct Haystack::Transfer::Endpoint
  include Hapi::Endpoint

  def init(**params)
    yield init(**params)
  end

  def init(**params) : Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def init(transfers : Array(NamedTuple), **params)
    yield init(transfers, **params)
  end

  def init(transfers : Array(NamedTuple), **params) : List
    @client.post(
      "#{self.class.uri.path}/bulk",
      body: params.merge({transfers: transfers}).to_json
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def finalise(**params)
    yield finalise(**params)
  end

  def finalise(**params) : Item
    @client.post(
      "#{self.class.uri.path}/finalize_transfer",
      body: params.to_json
    ) do |response|
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

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.from_json(response.body_io)
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

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transfer"
    uri
  end
end
