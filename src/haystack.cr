require "json"
require "http/client"

require "./haystack/version"
require "./haystack/**"

class Haystack
  def initialize(secret_key)
    set_headers(secret_key)
  end

  forward_missing_to http_client

  def banks : Bank::Endpoint
    @banks ||= Bank::Endpoint.new(self)
  end

  def bulk_charges : BulkCharge::Endpoint
    @bulk_charges ||= BulkCharge::Endpoint.new(self)
  end

  def charges : Charge::Endpoint
    @charges ||= Charge::Endpoint.new(self)
  end

  def countries : Country::Endpoint
    @countries ||= Country::Endpoint.new(self)
  end

  def customers : Customer::Endpoint
    @customers ||= Customer::Endpoint.new(self)
  end

  def disputes : Dispute::Endpoint
    @disputes ||= Dispute::Endpoint.new(self)
  end

  def invoices : Invoice::Endpoint
    @invoices ||= Invoice::Endpoint.new(self)
  end

  def nubans : Nuban::Endpoint
    @nubans ||= Nuban::Endpoint.new(self)
  end

  def pages : Page::Endpoint
    @pages ||= Page::Endpoint.new(self)
  end

  def plans : Plan::Endpoint
    @plans ||= Plan::Endpoint.new(self)
  end

  def products : Product::Endpoint
    @products ||= Product::Endpoint.new(self)
  end

  def recipients : Recipient::Endpoint
    @recipients ||= Recipient::Endpoint.new(self)
  end

  def refunds : Refund::Endpoint
    @refunds ||= Refund::Endpoint.new(self)
  end

  def settlements : Settlement::Endpoint
    @settlements ||= Settlement::Endpoint.new(self)
  end

  def splits : Split::Endpoint
    @splits ||= Split::Endpoint.new(self)
  end

  def subaccounts : Subaccount::Endpoint
    @subaccounts ||= Subaccount::Endpoint.new(self)
  end

  def subscriptions : Subscription::Endpoint
    @subscriptions ||= Subscription::Endpoint.new(self)
  end

  def transactions : Transaction::Endpoint
    @transactions ||= Transaction::Endpoint.new(self)
  end

  def transfers : Transfer::Endpoint
    @transfers ||= Transfer::Endpoint.new(self)
  end

  def self.path : String
    "/"
  end

  def self.uri : URI
    uri = base_uri
    uri.path = path
    uri
  end

  def self.base_uri : URI
    URI.parse("https://api.paystack.co")
  end

  private def set_headers(secret_key)
    http_client.before_request do |request|
      set_content_type(request.headers)
      set_user_agent(request.headers)
      set_authorization(request.headers, secret_key)
    end
  end

  private def http_client : HTTP::Client
    @http_client ||= HTTP::Client.new(self.class.base_uri)
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
