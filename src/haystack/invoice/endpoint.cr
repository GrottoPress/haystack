struct Haystack::Invoice::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
      Item.new(response)
    end
  end

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

  def fetch(id : String | Int)
    yield fetch(id)
  end

  def fetch(id : String | Int) : Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Item.new(response)
    end
  end

  def update(id : String | Int, **params)
    yield update(id, **params)
  end

  def update(id : String | Int, **params) : Item
    @client.put(
      "#{self.class.uri.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def verify(code : String)
    yield verify(code)
  end

  def verify(code : String) : Item
    @client.get("#{self.class.uri.path}/verify/#{code}") do |response|
      Item.new(response)
    end
  end

  def notify(id : String | Int)
    yield notify(id)
  end

  def notify(id : String | Int) : Notification::Item
    @client.post("#{self.class.uri.path}/notify/#{id}") do |response|
      Notification::Item.new(response)
    end
  end

  def totals
    yield totals
  end

  def totals : Totals::Item
    @client.get("#{self.class.uri.path}/totals") do |response|
      Totals::Item.new(response)
    end
  end

  def finalise(id : String | Int)
    yield finalise(id)
  end

  def finalise(id : String | Int) : Item
    @client.post("#{self.class.uri.path}/finalize/#{id}") do |response|
      Item.new(response)
    end
  end

  def archive(id : String | Int)
    yield archive(id)
  end

  def archive(id : String | Int) : Item
    @client.post("#{self.class.uri.path}/archive/#{id}") do |response|
      Item.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "paymentrequest"
    uri
  end
end
