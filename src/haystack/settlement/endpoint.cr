struct Haystack::Settlement::Endpoint
  include Haystack::Endpoint

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    )

    List.from_json(response.body)
  end

  def transactions(id : Int, **params)
    yield transactions(id, **params)
  end

  def transactions(id : Int, **params) : Transaction::List
    response = @client.get(
      "#{self.class.uri.path}/#{id}/transactions?#{URI::Params.encode(params)}"
    )

    Transaction::List.from_json(response.body)
  end

  def self.uri : URI
    Haystack.uri.tap do |uri|
      uri.path += "settlement"
    end
  end
end
