require "../spec_helper"

describe Haystack::Refund::Endpoint do
  describe "#create" do
    it "creates refund" do
      body = <<-JSON
        {
          "status": true,
          "message": "Refund created",
          "data": {
            "dispute": 14030,
            "transaction": {
              "id": 1641,
              "domain": "live",
              "status": "reversed",
              "reference": "x7g15k5iye",
              "amount": 2500,
              "message": null,
              "gateway_response": "Approved",
              "paid_at": "2018-06-27T09:50:55.000Z",
              "created_at": "2018-06-27T09:50:00.000Z",
              "channel": "card",
              "currency": "NGN",
              "ip_address": "54.162.150.5, 172.68.65.71, 172.31.7.148",
              "metadata": {
                "custom_fields": [
                  {
                    "display_name": "Started From",
                    "variable_name": "started_from",
                    "value": "sample charge card backend"
                  },
                  {
                    "display_name": "Requested by",
                    "variable_name": "requested_by",
                    "value": "Mr. Akinlade"
                  },
                  {
                    "display_name": "Server",
                    "variable_name": "server",
                    "value": "infinite-peak-60063.herokuapp.com"
                  }
                ]
              },
              "log": null,
              "fees": 38,
              "fees_split": null,
              "authorization": {},
              "customer": 22421,
              "plan": {},
              "subaccount": {},
              "paidAt": "2018-06-27T09:50:55.000Z",
              "createdAt": "2018-06-27T09:50:00.000Z"
            },
            "currency": "NGN",
            "amount": 2500,
            "channel": null,
            "customer_note": "I love people",
            "merchant_note": "People are awesome",
            "integration": 100073,
            "domain": "live",
            "status": "pending",
            "refunded_by": "refunds@paystack.co",
            "refunded_at": "2018-07-05T12:03:26.269Z",
            "expected_at": "2018-07-12T12:03:26.000Z",
            "fully_deducted": false,
            "id": 5679,
            "createdAt": "2018-07-05T12:03:26.269Z",
            "updatedAt": "2018-07-05T12:03:26.269Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/refund")
        .with(body: %({"transaction":1641}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.refunds.create(transaction: 1641) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Refund)
      end
    end
  end

  describe "#list" do
    it "lists refunds" do
      body = <<-JSON
        {
          "status": true,
          "message": "Refunds retrieved",
          "data": [
            {
              "id": 1,
              "integration": 100982,
              "domain": "live",
              "transaction": 1641,
              "dispute": 20,
              "amount": 500000,
              "deducted_amount": 500000,
              "currency": "NGN",
              "channel": "migs",
              "fully_deducted": 1,
              "refunded_by": "customer@gmail.com",
              "refunded_at": "2018-01-12T10:54:47.000Z",
              "expected_at": "2017-10-01T21:10:59.000Z",
              "settlement": null,
              "customer_note": "xxx",
              "merchant_note": "xxx",
              "created_at": "2017-09-24T21:10:59.000Z",
              "updated_at": "2018-01-18T11:59:56.000Z",
              "status": "processed"
            },
            {
              "id": 2,
              "integration": 100982,
              "domain": "test",
              "transaction": 323896,
              "dispute": 45,
              "amount": 500000,
              "deducted_amount": null,
              "currency": "NGN",
              "channel": "migs",
              "fully_deducted": null,
              "refunded_by": "customer@gmail.com",
              "refunded_at": "2017-09-24T21:11:53.000Z",
              "expected_at": "2017-10-01T21:11:53.000Z",
              "settlement": null,
              "customer_note": "xxx",
              "merchant_note": "xxx",
              "created_at": "2017-09-24T21:11:53.000Z",
              "updated_at": "2017-09-24T21:11:53.000Z",
              "status": "pending"
            }
          ]
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/refund")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.refunds.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Refund))
      end
    end
  end

  describe "#fetch" do
    it "fetches refund" do
      body = <<-JSON
        {
          "status": true,
          "message": "Refund retrieved",
          "data": {
            "integration": 100982,
            "transaction": 1641,
            "dispute": null,
            "settlement": null,
            "domain": "live",
            "amount": 500000,
            "deducted_amount": 500000,
            "fully_deducted": true,
            "currency": "NGN",
            "channel": "migs",
            "status": "processed",
            "refunded_by": "eseyinwale@gmail.com",
            "refunded_at": "2018-01-12T10:54:47.000Z",
            "expected_at": "2017-10-01T21:10:59.000Z",
            "customer_note": "xxx",
            "merchant_note": "xxx",
            "id": 1,
            "createdAt": "2017-09-24T21:10:59.000Z",
            "updatedAt": "2018-01-18T11:59:56.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/refund/123456")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.refunds.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Refund)
      end
    end
  end
end
