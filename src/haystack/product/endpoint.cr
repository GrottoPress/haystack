struct Haystack::Product::Endpoint
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Item.from_json(response.body)
  end

  def update(id : Int, **params)
    yield update(id, **params)
  end

  def update(id : Int, **params) : Item
    response = @client.put("#{self.class.uri.path}/#{id}", body: params.to_json)
    Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "product"
    uri
  end
end
