struct Haystack::Dispute::Endpoint
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Item.from_json(response.body)
  end

  def for_transaction(transaction_id : Int, **params)
    yield for_transaction(transaction_id, **params)
  end

  def for_transaction(transaction_id : Int, **params) : List
    response = @client.get(
      "#{self.class.uri.path}/transaction/#{transaction_id}?#{
        URI::Params.encode(params)}"
    )

    List.from_json(response.body)
  end

  def update(id : Int, **params)
    yield update(id, **params)
  end

  def update(id : Int, **params) : Item
    response = @client.put("#{self.class.uri.path}/#{id}", body: params.to_json)
    Item.from_json(response.body)
  end

  def add_evidence(id : Int, **params)
    yield add_evidence(id, **params)
  end

  def add_evidence(id : Int, **params) : Evidence::Item
    response = @client.post(
      "#{self.class.uri.path}/#{id}/evidence",
      body: params.to_json
    )

    Evidence::Item.from_json(response.body)
  end

  def upload_url(id : Int, **params)
    yield upload_url(id, **params)
  end

  def upload_url(id : Int, **params) : UploadUrl::Item
    response = @client.get(
      "#{self.class.uri.path}/#{id}/upload_url?#{URI::Params.encode(params)}"
    )

    UploadUrl::Item.from_json(response.body)
  end

  def resolve(id : Int, **params)
    yield resolve(id, **params)
  end

  def resolve(id : Int, **params) : Item
    response = @client.put(
      "#{self.class.uri.path}/#{id}/resolve",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def export(**params)
    yield export(**params)
  end

  def export(**params) : Export::Item
    response = @client.get(
      "#{self.class.uri.path}/export?#{URI::Params.encode(params)}"
    )

    Export::Item.from_json(response.body)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "dispute"
    uri
  end
end
