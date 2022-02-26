struct Haystack::BulkCharge::Endpoint
  include Hapi::Endpoint

  def initiate(charges : Array(NamedTuple))
    yield initiate(charges)
  end

  def initiate(charges : Array(NamedTuple)) : Item
    @client.post(self.class.uri.path, body: charges.to_json) do |response|
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

  def charges(id : String | Int)
    yield charges(id)
  end

  def charges(id : String | Int) : Charge::List
    @client.get("#{self.class.uri.path}/#{id}/charges") do |response|
      Charge::List.new(response)
    end
  end

  def pause(batch_code : String)
    yield pause(batch_code)
  end

  def pause(batch_code : String) : Item
    @client.get("#{self.class.uri.path}/pause/#{batch_code}") do |response|
      Item.new(response)
    end
  end

  def resume(batch_code : String)
    yield resume(batch_code)
  end

  def resume(batch_code : String) : Item
    @client.get("#{self.class.uri.path}/resume/#{batch_code}") do |response|
      Item.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "bulkcharge"
    uri
  end
end
