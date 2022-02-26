struct Haystack::Settlement::Endpoint
  include Hapi::Endpoint

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

  def transactions(id : Int, **params)
    yield transactions(id, **params)
  end

  def transactions(id : Int, **params) : Transaction::List
    @client.get(
      "#{self.class.uri.path}/#{id}/transactions?#{URI::Params.encode(params)}"
    ) do |response|
      Transaction::List.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "settlement"
    uri
  end
end
