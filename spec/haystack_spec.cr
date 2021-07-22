require "./spec_helper"

describe Haystack do
  ENV["PAYSTACK_SECRET_KEY"]?.try do |secret_key|
    it "connects to Paystack" do
      WebMock.allow_net_connect = true

      paystack = Haystack.new(secret_key)

      paystack.transactions.initiate(
        email: "customer@email.com",
        amount: "20000"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction::Authorization)
      end
    end
  end
end
