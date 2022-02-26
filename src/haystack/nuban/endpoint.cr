struct Haystack::Nuban::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Bank::Account::Item
    @client.post(self.class.uri.path, body: params.to_json) do |response|
      Bank::Account::Item.new(response)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : Bank::Account::List
    @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    ) do |response|
      Bank::Account::List.new(response)
    end
  end

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Customer::Item
    @client.get("#{self.class.uri.path}/#{id}") do |response|
      Customer::Item.new(response)
    end
  end

  def deactivate(id : Int)
    yield deactivate(id)
  end

  def deactivate(id : Int) : Bank::Account::Item
    @client.delete("#{self.class.uri.path}/#{id}") do |response|
      Bank::Account::Item.new(response)
    end
  end

  def split(**params)
    yield split(**params)
  end

  def split(**params) : Bank::Account::Item
    @client.post(
      "#{self.class.uri.path}/split",
      body: params.to_json
    ) do |response|
      Bank::Account::Item.new(response)
    end
  end

  def unsplit(**params)
    yield unsplit(**params)
  end

  def unsplit(**params) : Bank::Account::Item
    @client.delete(
      "#{self.class.uri.path}/split",
      body: params.to_json
    ) do |response|
      Bank::Account::Item.new(response)
    end
  end

  def providers(**params)
    yield providers(**params)
  end

  def providers(**params) : Bank::Provider::List
    @client.get(
      "#{self.class.uri.path}/available_providers?#{URI::Params.encode(params)}"
    ) do |response|
      Bank::Provider::List.new(response)
    end
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "dedicated_account"
    uri
  end
end
