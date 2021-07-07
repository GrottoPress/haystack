struct Haystack::Settlement::Endpoint
  def initialize(@haystack : Haystack)
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

  def transactions(id : Int, **params)
    yield transactions(id, **params)
  end

  def transactions(id : Int, **params) : Transaction::List
    @haystack.get(
      "#{self.class.path}/#{id}/transactions?#{URI::Params.encode(params)}"
    ) do |response|
      Transaction::List.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}settlement"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
