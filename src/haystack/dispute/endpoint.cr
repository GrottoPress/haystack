struct Haystack::Dispute::Endpoint
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

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Item
    @haystack.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def for_transaction(transaction_id : Int, **params)
    yield for_transaction(transaction_id, **params)
  end

  def for_transaction(transaction_id : Int, **params) : List
    @haystack.get(
      "#{self.class.path}/transaction/#{transaction_id}?#{
        URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def update(id : Int, **params)
    yield update(id, **params)
  end

  def update(id : Int, **params) : Item
    @haystack.put(
      "#{self.class.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def add_evidence(id : Int, **params)
    yield add_evidence(id, **params)
  end

  def add_evidence(id : Int, **params) : Evidence::Item
    @haystack.post(
      "#{self.class.path}/#{id}/evidence",
      body: params.to_json
    ) do |response|
      Evidence::Item.from_json(response.body_io)
    end
  end

  def upload_url(id : Int, **params)
    yield upload_url(id, **params)
  end

  def upload_url(id : Int, **params) : UploadUrl::Item
    @haystack.get(
      "#{self.class.path}/#{id}/upload_url?#{URI::Params.encode(params)}"
    ) do |response|
      UploadUrl::Item.from_json(response.body_io)
    end
  end

  def resolve(id : Int, **params)
    yield resolve(id, **params)
  end

  def resolve(id : Int, **params) : Item
    @haystack.put(
      "#{self.class.path}/#{id}/resolve",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
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

  def self.path : String
    "#{Haystack.path}dispute"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
