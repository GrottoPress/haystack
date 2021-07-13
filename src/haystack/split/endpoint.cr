struct Haystack::Split::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.from_json(response.body_io)
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
      Item.from_json(response.body_io)
    end
  end

  def update_account(id : Int, **params)
    yield update_account(id, **params)
  end

  def update_account(id : Int, **params) : Item
    add_account(id, **params)
  end

  def add_account(id : Int, **params)
    yield add_account(id, **params)
  end

  def add_account(id : Int, **params) : Item
    @client.post(
      "#{self.class.uri.path}/#{id}/subaccount/add",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def remove_account(id : Int, **params)
    yield remove_account(id, **params)
  end

  def remove_account(id : Int, **params) : Item
    @client.post(
      "#{self.class.uri.path}/#{id}/subaccount/remove",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "split"
    uri
  end
end
