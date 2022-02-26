struct Haystack::Settlement::Endpoint
  include Hapi::Endpoint

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    )

    List.new(response)
  end

  def transactions(id : Int, **params)
    yield transactions(id, **params)
  end

  def transactions(id : Int, **params) : Transaction::List
    response = @client.get(
      "#{self.class.uri.path}/#{id}/transactions?#{URI::Params.encode(params)}"
    )

    Transaction::List.new(response)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "settlement"
    uri
  end
end
