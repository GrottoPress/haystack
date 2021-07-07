struct Haystack::Transfer::Endpoint
  def initialize(@haystack : Haystack)
  end

  def init(**params)
    yield init(**params)
  end

  def init(**params) : Item
    @haystack.post(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def init(transfers : Array(NamedTuple), **params)
    yield init(transfers, **params)
  end

  def init(transfers : Array(NamedTuple), **params) : List
    @haystack.post(
      "#{self.class.path}/bulk",
      body: params.merge({transfers: transfers}).to_json
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def finalise(**params)
    yield finalise(**params)
  end

  def finalise(**params) : Item
    @haystack.post(
      "#{self.class.path}/finalize_transfer",
      body: params.to_json
    ) do |response|
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

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    @haystack.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def verify(reference : String)
    yield verify(reference)
  end

  def verify(reference : String) : Item
    @haystack.get("#{self.class.path}/verify/#{reference}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}transfer"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
