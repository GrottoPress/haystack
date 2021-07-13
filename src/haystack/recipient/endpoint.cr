struct Haystack::Recipient::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def create(batch : Array(NamedTuple))
    yield create(batch)
  end

  def create(batch : Array(NamedTuple)) : Bulk::Item
    @client.post(
      "#{self.class.uri.path}/bulk",
      body: {batch: batch}.to_json
    ) do |response|
      Bulk::Item.from_json(response.body_io)
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

  def update(id : String | Int, **params)
    yield update(id, **params)
  end

  def update(id : String | Int, **params) : Item
    @client.put(
      "#{self.class.uri.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def delete(id : String | Int)
    yield delete(id)
  end

  def delete(id : String | Int) : Item
    @client.delete("#{self.class.uri.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "transferrecipient"
    uri
  end
end
