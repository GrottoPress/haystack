struct Haystack::Bank::Endpoint
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

  def verify_account(**params)
    yield verify_account(**params)
  end

  def verify_account(**params) : Verification::Item
    @haystack.get(
      "#{self.class.path}/resolve?#{URI::Params.encode(params)}"
    ) do |response|
      Verification::Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}bank"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
