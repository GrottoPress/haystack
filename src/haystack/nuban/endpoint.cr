struct Haystack::Nuban::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Bank::Account::Item
    response = @client.post(self.class.uri.path, body: params.to_json)
    Bank::Account::Item.new(response)
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : Bank::Account::List
    response = @client.get(
      "#{self.class.uri.path}?#{URI::Params.encode(params)}"
    )

    Bank::Account::List.new(response)
  end

  def fetch(id : Int)
    yield fetch(id)
  end

  def fetch(id : Int) : Customer::Item
    response = @client.get("#{self.class.uri.path}/#{id}")
    Customer::Item.new(response)
  end

  def deactivate(id : Int)
    yield deactivate(id)
  end

  def deactivate(id : Int) : Bank::Account::Item
    response = @client.delete("#{self.class.uri.path}/#{id}")
    Bank::Account::Item.new(response)
  end

  def split(**params)
    yield split(**params)
  end

  def split(**params) : Bank::Account::Item
    response = @client.post(
      "#{self.class.uri.path}/split",
      body: params.to_json
    )

    Bank::Account::Item.new(response)
  end

  def unsplit(**params)
    yield unsplit(**params)
  end

  def unsplit(**params) : Bank::Account::Item
    response = @client.delete(
      "#{self.class.uri.path}/split",
      body: params.to_json
    )

    Bank::Account::Item.new(response)
  end

  def providers(**params)
    yield providers(**params)
  end

  def providers(**params) : Bank::Provider::List
    response = @client.get(
      "#{self.class.uri.path}/available_providers?#{URI::Params.encode(params)}"
    )

    Bank::Provider::List.new(response)
  end

  def self.uri : URI
    uri = Haystack.uri
    uri.path += "dedicated_account"
    uri
  end
end
