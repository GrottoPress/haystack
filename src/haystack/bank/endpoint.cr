struct Haystack::Bank::Endpoint
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

  def verify_account(**params)
    yield verify_account(**params)
  end

  def verify_account(**params) : Verification::Item
    @client.get(
      "#{self.class.uri.path}/resolve?#{URI::Params.encode(params)}"
    ) do |response|
      Verification::Item.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "bank"
    uri
  end
end
