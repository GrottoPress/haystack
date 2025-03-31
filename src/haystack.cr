require "crypto/subtle"
require "http/client"
require "json"
require "openssl/hmac"

require "./haystack/version"
require "./haystack/endpoint"
require "./haystack/resource"
require "./haystack/macros"
require "./haystack/**"

struct Haystack
  def initialize(secret_key)
    @http_client = HTTP::Client.new(self.class.uri)
    set_headers(secret_key)
  end

  forward_missing_to @http_client

  def banks : Bank::Endpoint
    Bank::Endpoint.new(self)
  end

  def bulk_charges : BulkCharge::Endpoint
    BulkCharge::Endpoint.new(self)
  end

  def charges : Charge::Endpoint
    Charge::Endpoint.new(self)
  end

  def countries : Country::Endpoint
    Country::Endpoint.new(self)
  end

  def customers : Customer::Endpoint
    Customer::Endpoint.new(self)
  end

  def disputes : Dispute::Endpoint
    Dispute::Endpoint.new(self)
  end

  def invoices : Invoice::Endpoint
    Invoice::Endpoint.new(self)
  end

  def nubans : Nuban::Endpoint
    Nuban::Endpoint.new(self)
  end

  def pages : Page::Endpoint
    Page::Endpoint.new(self)
  end

  def plans : Plan::Endpoint
    Plan::Endpoint.new(self)
  end

  def products : Product::Endpoint
    Product::Endpoint.new(self)
  end

  def recipients : Recipient::Endpoint
    Recipient::Endpoint.new(self)
  end

  def refunds : Refund::Endpoint
    Refund::Endpoint.new(self)
  end

  def settlements : Settlement::Endpoint
    Settlement::Endpoint.new(self)
  end

  def splits : Split::Endpoint
    Split::Endpoint.new(self)
  end

  def subaccounts : Subaccount::Endpoint
    Subaccount::Endpoint.new(self)
  end

  def subscriptions : Subscription::Endpoint
    Subscription::Endpoint.new(self)
  end

  def transactions : Transaction::Endpoint
    Transaction::Endpoint.new(self)
  end

  def transfers : Transfer::Endpoint
    Transfer::Endpoint.new(self)
  end

  def self.uri : URI
    URI.parse("https://api.paystack.co/")
  end

  private def set_headers(secret_key)
    @http_client.before_request do |request|
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
