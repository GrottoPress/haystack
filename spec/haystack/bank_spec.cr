require "../spec_helper"

describe Haystack::Bank::Endpoint do
  describe "#verify_account" do
    it "verifies account" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Account number resolved",
          "data": {
            "account_number": "0022728151",
            "account_name": "WES GIBBONS",
            "bank_id": 58
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bank/resolve")
        .with(query: {"account_number" => "0022728151", "bank_code" => "063"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.banks.verify_account(
        account_number: "0022728151",
        bank_code: "063"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Bank::Verification)
      end
    end
  end

  describe "#list" do
    it "lists banks" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Banks retrieved",
          "data": [
            {
              "name": "Abbey Mortgage Bank",
              "slug": "abbey-mortgage-bank",
              "code": "801",
              "longcode": "",
              "gateway": null,
              "pay_with_bank": false,
              "active": true,
              "is_deleted": false,
              "country": "Nigeria",
              "currency": "NGN",
              "type": "nuban",
              "id": 174,
              "createdAt": "2020-12-07T16:19:09.000Z",
              "updatedAt": "2020-12-07T16:19:19.000Z"
            },
            {
              "name": "Coronation Merchant Bank",
              "slug": "coronation-merchant-bank",
              "code": "559",
              "longcode": "",
              "gateway": null,
              "pay_with_bank": false,
              "active": true,
              "is_deleted": false,
              "country": "Nigeria",
              "currency": "NGN",
              "type": "nuban",
              "id": 173,
              "createdAt": "2020-11-24T10:25:07.000Z",
              "updatedAt": "2020-11-24T10:25:07.000Z"
            }
          ],
          "meta": {
            "next": "YmFuazoxNjk=",
            "previous": null,
            "perPage": 5
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bank")
        .with(query: {"country" => "ghana"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.banks.list(country: "ghana") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Bank))
      end
    end

    it "lists providers" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "NUBAN Providers successfully retrieved",
          "data": [
            {
              "name": "Wema Bank",
              "slug": "wema-bank",
              "code": "035",
              "longcode": "035150103",
              "gateway": null,
              "pay_with_bank": false,
              "active": true,
              "is_deleted": null,
              "country": "Nigeria",
              "currency": "NGN",
              "type": "nuban",
              "id": 20,
              "createdAt": "2016-07-14T10:04:29.000Z",
              "updatedAt": "2021-02-09T17:49:59.000Z"
            }
          ]
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/bank")
        .with(query: {"pay_with_bank_transfer" => "true"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.banks.list(pay_with_bank_transfer: "true") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Bank))
      end
    end
  end
end
