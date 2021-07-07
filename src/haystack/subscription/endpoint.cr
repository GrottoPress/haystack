struct Haystack::Subscription::Endpoint
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

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    @haystack.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def enable(**params)
    yield enable(**params)
  end

  def enable(**params) : Item
    @haystack.post(
      "#{self.class.path}/enable",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def disable(**params)
    yield disable(**params)
  end

  def disable(**params) : Item
    @haystack.post(
      "#{self.class.path}/disable",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}subscription"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
