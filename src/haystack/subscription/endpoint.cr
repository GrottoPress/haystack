struct Haystack::Subscription::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
      Item.new(response)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    ) do |response|
      List.new(response)
    end
  end

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.new(response)
    end
  end

  def enable(**params)
    yield enable(**params)
  end

  def enable(**params) : Item
    @client.post(
      "#{self.class.uri.path}/enable",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def disable(**params)
    yield disable(**params)
  end

  def disable(**params) : Item
    @client.post(
      "#{self.class.uri.path}/disable",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "subscription"
    uri
  end
end
