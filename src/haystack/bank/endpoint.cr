struct Haystack::Bank::Endpoint
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

  def verify_account(**params)
    yield verify_account(**params)
  end

  def verify_account(**params) : Verification::Item
    response = @client.get(
      "#{self.class.uri.path}/resolve?#{URI::Params.encode(params)}"
    )

    Verification::Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "bank"
    uri
  end
end
