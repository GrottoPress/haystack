struct Haystack::Refund::Endpoint
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    @haystack.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}refund"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
