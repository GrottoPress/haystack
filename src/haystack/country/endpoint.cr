struct Haystack::Country::Endpoint
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

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "country"
    uri
  end
end
