struct Haystack::Recipient::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    response = @client.post(self.class.uri.path, body: params.to_json)
    Item.new(response)
  end

  def create(batch : Array(NamedTuple))
    yield create(batch)
  end

  def create(batch : Array(NamedTuple)) : Bulk::Item
    response = @client.post(
      "#{self.class.uri.path}/bulk",
      body: {batch: batch}.to_json
    )

    Bulk::Item.new(response)
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    )

    List.new(response)
  end

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Item.new(response)
  end

  def update(id : String | Int, **params)
    yield update(id, **params)
  end

  def update(id : String | Int, **params) : Item
    response = @client.put("#{self.class.uri.path}/#{id}", body: params.to_json)
    Item.new(response)
  end

  def delete(id : String | Int)
    yield delete(id)
  end

  def delete(id : String | Int) : Item
    response = @client.delete("#{self.class.uri.path}/#{id}")
    Item.new(response)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transferrecipient"
    uri
  end
end
