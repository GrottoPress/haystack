require "crypto/subtle"
require "digest/sha512"

require "hapi"

require "./haystack/version"
require "./haystack/macros"
require "./haystack/**"

class Haystack
  include Hapi::Client

  def initialize(secret_key)
    set_headers(secret_key)
  end

  getter banks : Bank::Endpoint do
    Bank::Endpoint.new(self)
  end

  getter bulk_charges : BulkCharge::Endpoint do
    BulkCharge::Endpoint.new(self)
  end

  getter charges : Charge::Endpoint do
    Charge::Endpoint.new(self)
  end

  getter countries : Country::Endpoint do
    Country::Endpoint.new(self)
  end

  getter customers : Customer::Endpoint do
    Customer::Endpoint.new(self)
  end

  getter disputes : Dispute::Endpoint do
    Dispute::Endpoint.new(self)
  end

  getter invoices : Invoice::Endpoint do
    Invoice::Endpoint.new(self)
  end

  getter nubans : Nuban::Endpoint do
    Nuban::Endpoint.new(self)
  end

  getter pages : Page::Endpoint do
    Page::Endpoint.new(self)
  end

  getter plans : Plan::Endpoint do
    Plan::Endpoint.new(self)
  end

  getter products : Product::Endpoint do
    Product::Endpoint.new(self)
  end

  getter recipients : Recipient::Endpoint do
    Recipient::Endpoint.new(self)
  end

  getter refunds : Refund::Endpoint do
    Refund::Endpoint.new(self)
  end

  getter settlements : Settlement::Endpoint do
    Settlement::Endpoint.new(self)
  end

  getter splits : Split::Endpoint do
    Split::Endpoint.new(self)
  end

  getter subaccounts : Subaccount::Endpoint do
    Subaccount::Endpoint.new(self)
  end

  getter subscriptions : Subscription::Endpoint do
    Subscription::Endpoint.new(self)
  end

  getter transactions : Transaction::Endpoint do
    Transaction::Endpoint.new(self)
  end

  getter transfers : Transfer::Endpoint do
    Transfer::Endpoint.new(self)
  end

  def self.uri : URI
    URI.parse("https://api.paystack.co/")
  end

  private def set_headers(secret_key)
    http_client.before_request do |request|
      set_content_type(request.headers)
      set_user_agent(request.headers)
      set_authorization(request.headers, secret_key)
    end
  end

  private def set_content_type(headers)
    headers["Content-Type"] = "application/json; charset=UTF-8"
  end

  private def set_user_agent(headers)
    headers["User-Agent"] = "Haystack/#{Haystack::VERSION} \
      (+https://github.com/GrottoPress/haystack)"
  end

  private def set_authorization(headers, secret_key)
    headers["Authorization"] = "Bearer #{secret_key}"
  end
end
