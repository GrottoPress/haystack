struct Haystack::Product::Endpoint
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.new(response)
    end
  end

  def update(id : Int, **params)
    yield update(id, **params)
  end

  def update(id : Int, **params) : Item
    @client.put(
      "#{self.class.uri.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "product"
    uri
  end
end
