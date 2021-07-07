struct Haystack::Transaction::Endpoint
  def initialize(@haystack : Haystack)
  end

  def init(**params)
    yield init(**params)
  end

  def init(**params) : Initialization::Item
    @haystack.post(
      "#{self.class.path}/initialize",
      body: params.to_json
    ) do |response|
      Initialization::Item.from_json(response.body_io)
    end
  end

  def verify(reference : String)
    yield verify(reference)
  end

  def verify(reference : String) : Item
    @haystack.get("#{self.class.path}/verify/#{reference}") do |response|
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

  def charge_auth(**params)
    yield charge_auth(**params)
  end

  def charge_auth(**params) : Item
    @haystack.post(
      "#{self.class.path}/charge_authorization",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def check_auth(**params)
    yield check_auth(**params)
  end

  def check_auth(**params) : Amount::Item
    @haystack.post(
      "#{self.class.path}/check_authorization",
      body: params.to_json
    ) do |response|
      Amount::Item.from_json(response.body_io)
    end
  end

  def timeline(id : String | Int)
    yield timeline(id)
  end

  def timeline(id : String | Int) : Timeline::Item
    @haystack.get("#{self.class.path}/timeline/#{id}") do |response|
      Timeline::Item.from_json(response.body_io)
    end
  end

  def totals(**params)
    yield totals(**params)
  end

  def totals(**params) : Totals::Item
    @haystack.get(
      "#{self.class.path}/totals?#{URI::Params.encode(params)}"
    ) do |response|
      Totals::Item.from_json(response.body_io)
    end
  end

  def export(**params)
    yield export(**params)
  end

  def export(**params) : Export::Item
    @haystack.get(
      "#{self.class.path}/export?#{URI::Params.encode(params)}"
    ) do |response|
      Export::Item.from_json(response.body_io)
    end
  end

  def debit(**params)
    yield debit(**params)
  end

  def debit(**params) : Item
    @haystack.post(
      "#{self.class.path}/partial_debit",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}transaction"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
