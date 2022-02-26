struct Haystack::BulkCharge::Endpoint
  include Hapi::Endpoint

  def initiate(charges : Array(NamedTuple))
    yield initiate(charges)
  end

  def initiate(charges : Array(NamedTuple)) : Item
    response = @client.post(self.class.uri.path, body: charges.to_json)
    Item.new(response)
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

  def charges(id : String | Int)
    yield charges(id)
  end

  def charges(id : String | Int) : Charge::List
    response = @client.get("#{self.class.uri.path}/#{id}/charges")
    Charge::List.new(response)
  end

  def pause(batch_code : String)
    yield pause(batch_code)
  end

  def pause(batch_code : String) : Item
    response = @client.get("#{self.class.uri.path}/pause/#{batch_code}")
    Item.new(response)
  end

  def resume(batch_code : String)
    yield resume(batch_code)
  end

  def resume(batch_code : String) : Item
    response = @client.get("#{self.class.uri.path}/resume/#{batch_code}")
    Item.new(response)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "bulkcharge"
    uri
  end
end
