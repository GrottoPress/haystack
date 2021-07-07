struct Haystack::Invoice::Endpoint
  def initialize(@haystack : Haystack)
  end

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @haystack.post(self.class.path, body: params.to_json) do |response|
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

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    @haystack.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(id : String | Int, **params)
    yield update(id, **params)
  end

  def update(id : String | Int, **params) : Item
    @haystack.put(
      "#{self.class.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def verify(code : String)
    yield verify(code)
  end

  def verify(code : String) : Item
    @haystack.get("#{self.class.path}/verify/#{code}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def notify(id : String | Int)
    yield notify(id)
  end

  def notify(id : String | Int) : Notification::Item
    @haystack.post("#{self.class.path}/notify/#{id}") do |response|
      Notification::Item.from_json(response.body_io)
    end
  end

  def totals
    yield totals
  end

  def totals : Totals::Item
    @haystack.get("#{self.class.path}/totals") do |response|
      Totals::Item.from_json(response.body_io)
    end
  end

  def finalise(id : String | Int)
    yield finalise(id)
  end

  def finalise(id : String | Int) : Item
    @haystack.post("#{self.class.path}/finalize/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def archive(id : String | Int)
    yield archive(id)
  end

  def archive(id : String | Int) : Item
    @haystack.post("#{self.class.path}/archive/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Haystack.path}paymentrequest"
  end

  def self.uri : URI
    uri = Haystack.base_uri
    uri.path = path
    uri
  end
end
