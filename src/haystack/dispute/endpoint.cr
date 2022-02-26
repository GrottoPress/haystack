struct Haystack::Dispute::Endpoint
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.new(response)
    end
  end

  def for_transaction(transaction_id : Int, **params)
    yield for_transaction(transaction_id, **params)
  end

  def for_transaction(transaction_id : Int, **params) : List
    @client.get(
      "#{self.class.uri.path}/transaction/#{transaction_id}?#{
        URI::Params.encode(params)}"
    ) do |response|
      List.new(response)
    end
  end

  def update(id : Int, **params)
    yield update(id, **params)
  end

  def update(id : Int, **params) : Item
    @client.put(
      "#{self.class.uri.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def add_evidence(id : Int, **params)
    yield add_evidence(id, **params)
  end

  def add_evidence(id : Int, **params) : Evidence::Item
    @client.post(
      "#{self.class.uri.path}/#{id}/evidence",
      body: params.to_json
    ) do |response|
      Evidence::Item.new(response)
    end
  end

  def upload_url(id : Int, **params)
    yield upload_url(id, **params)
  end

  def upload_url(id : Int, **params) : UploadUrl::Item
    @client.get(
      "#{self.class.uri.path}/#{id}/upload_url?#{URI::Params.encode(params)}"
    ) do |response|
      UploadUrl::Item.new(response)
    end
  end

  def resolve(id : Int, **params)
    yield resolve(id, **params)
  end

  def resolve(id : Int, **params) : Item
    @client.put(
      "#{self.class.uri.path}/#{id}/resolve",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def export(**params)
    yield export(**params)
  end

  def export(**params) : Export::Item
    @client.get(
      "#{self.class.uri.path}/export?#{URI::Params.encode(params)}"
    ) do |response|
      Export::Item.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "dispute"
    uri
  end
end
