require "../spec_helper"

describe Haystack::BulkCharge::Endpoint do
  describe "#init" do
    it "initiates bulk charge" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Charges have been queued",
          "data": {
            "domain": "test",
            "batch_code": "BCH_180tl7oq7cayggh",
            "status": "active",
            "id": 17,
            "integration": 100073,
            "createdAt": "2017-02-04T05:44:19.000Z",
            "updatedAt": "2017-02-04T05:44:19.000Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/bulkcharge")
        .with(body: %([\
          {"authorization":"AUTH_n95vpedf","amount":2500},\
          {"authorization":"AUTH_ljdt4e4j","amount":1500}\
        ]))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.bulk_charges.initiate([
        {authorization: "AUTH_n95vpedf", amount: 2500},
        {authorization: "AUTH_ljdt4e4j", amount: 1500}
      ]) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::BulkCharge)
      end
    end
  end

  describe "#list" do
    it "lists bulk charges" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Bulk charges retrieved",
          "data": [
            {
              "domain": "test",
              "batch_code": "BCH_1nV4L1D7cayggh",
              "status": "complete",
              "id": 1733,
              "createdAt": "2017-02-04T05:44:19.000Z",
              "updatedAt": "2017-02-04T05:45:02.000Z"
            }
          ],
          "meta": {
            "total": 1,
            "skipped": 0,
            "perPage": 50,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bulkcharge")
        .with(query: {"perBulkCharge" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.bulk_charges.list(perBulkCharge: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::BulkCharge))
      end
    end
  end

  describe "#fetch" do
    it "fetches bulk charge" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Bulk charge retrieved",
          "data": {
            "domain": "test",
            "batch_code": "BCH_180tl7oq7cayggh",
            "status": "complete",
            "id": 17,
            "total_charges": 0,
            "pending_charges": 0,
            "createdAt": "2017-02-04T05:44:19.000Z",
            "updatedAt": "2017-02-04T05:45:02.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bulkcharge/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.bulk_charges.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::BulkCharge)
      end
    end
  end

  describe "#charges" do
    it "fetches charges in a batch" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Bulk charge items retrieved",
          "data": [
            {
              "integration": 100073,
              "bulkcharge": 18,
              "customer": {
                "id": 181336,
                "first_name": null,
                "last_name": null,
                "email": "support@paystack.com",
                "customer_code": "CUS_dw5posshfd1i5uj",
                "phone": null,
                "metadata": null,
                "risk_action": "default"
              },
              "authorization": {
                "authorization_code": "AUTH_jh3cfpca",
                "bin": "412345",
                "last4": "1381",
                "exp_month": "08",
                "exp_year": "2088",
                "channel": "card",
                "card_type": "visa visa",
                "bank": "TEST BANK",
                "country_code": "NG",
                "brand": "visa",
                "reusable": true,
                "account_name": "BoJack Horseman"
              },
              "transaction": {
                "id": 718835,
                "domain": "test",
                "status": "success",
                "reference": "2mr588n0ik9enja",
                "amount": 20500,
                "message": null,
                "gateway_response": "Successful",
                "paid_at": "2017-02-04T06:05:02.000Z",
                "created_at": "2017-02-04T06:05:02.000Z",
                "channel": "card",
                "currency": "NGN",
                "ip_address": null,
                "metadata": "",
                "log": null,
                "fees": null,
                "fees_split": null,
                "customer": {},
                "authorization": {},
                "plan": {},
                "subaccount": {},
                "paidAt": "2017-02-04T06:05:02.000Z",
                "createdAt": "2017-02-04T06:05:02.000Z"
              },
              "domain": "test",
              "amount": 20500,
              "currency": "NGN",
              "status": "success",
              "id": 15,
              "createdAt": "2017-02-04T06:04:26.000Z",
              "updatedAt": "2017-02-04T06:05:03.000Z"
            },
            {
              "integration": 100073,
              "bulkcharge": 18,
              "customer": {
                "id": 181336,
                "first_name": null,
                "last_name": null,
                "email": "support@paystack.com",
                "customer_code": "CUS_dw5posshfd1i5uj",
                "phone": null,
                "metadata": null,
                "risk_action": "default"
              },
              "authorization": {
                "authorization_code": "AUTH_qdyfjbl3",
                "bin": "412345",
                "last4": "1381",
                "exp_month": "08",
                "exp_year": "2018",
                "channel": "card",
                "card_type": "visa visa",
                "bank": "TEST BANK",
                "country_code": "NG",
                "brand": "visa",
                "reusable": true,
                "account_name": "BoJack Horseman"
              },
              "transaction": {
                "id": 718836,
                "domain": "test",
                "status": "success",
                "reference": "5xkmvfe2h4065zl",
                "amount": 11500,
                "message": null,
                "gateway_response": "Successful",
                "paid_at": "2017-02-04T06:05:02.000Z",
                "created_at": "2017-02-04T06:05:02.000Z",
                "channel": "card",
                "currency": "NGN",
                "ip_address": null,
                "metadata": "",
                "log": null,
                "fees": null,
                "fees_split": null,
                "customer": {},
                "authorization": {},
                "plan": {},
                "subaccount": {},
                "paidAt": "2017-02-04T06:05:02.000Z",
                "createdAt": "2017-02-04T06:05:02.000Z"
              },
              "domain": "test",
              "amount": 11500,
              "currency": "NGN",
              "status": "success",
              "id": 16,
              "createdAt": "2017-02-04T06:04:26.000Z",
              "updatedAt": "2017-02-04T06:05:03.000Z"
            }
          ],
          "meta": {
            "total": 2,
            "skipped": 0,
            "perPage": 50,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bulkcharge/123456/charges")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.bulk_charges.charges(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::BulkCharge::Charge))
      end
    end
  end

  describe "#pause" do
    it "pauses bulk charge processing" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Bulk charge batch has been paused"
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bulkcharge/pause/a1b2c3")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.bulk_charges.pause("a1b2c3") do |response|
        response.success?.should be_true
      end
    end
  end

  describe "#resume" do
    it "resumes bulk charge processing" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Bulk charge batch has been resumed"
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bulkcharge/resume/a1b2c3")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.bulk_charges.resume("a1b2c3") do |response|
        response.success?.should be_true
      end
    end
  end
end
