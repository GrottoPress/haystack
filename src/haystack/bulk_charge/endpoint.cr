struct Haystack::BulkCharge::Endpoint
  def initialize(@haystack : Haystack)
  end

  def init(charges : Array(NamedTuple))
    yield init(charges)
  end

  def init(charges : Array(NamedTuple)) : Item
    @haystack.post(self.class.path, body: charges.to_json) do |response|
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

  def charges(id : String | Int)
    yield charges(id)
  end

  def charges(id : String | Int) : Charge::List
    @haystack.get("#{self.class.path}/#{id}/charges") do |response|
      Charge::List.from_json(response.body_io)
    end
  end

  def pause(batch_code : String)
    yield pause(batch_code)
  end

  def pause(batch_code : String) : Item
    @haystack.get("#{self.class.path}/pause/#{batch_code}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def resume(batch_code : String)
    yield resume(batch_code)
  end

  def resume(batch_code : String) : Item
    @haystack.get("#{self.class.path}/resume/#{batch_code}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}bulkcharge"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
