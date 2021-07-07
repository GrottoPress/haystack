require "../spec_helper"

describe Haystack::Subaccount::Endpoint do
  describe "#create" do
    it "creates subaccount" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subaccount created",
          "data": {
            "integration": 100973,
            "domain": "test",
            "subaccount_code": "ACCT_4hl4xenwpjy5wb",
            "business_name": "Sunshine Studios",
            "description": null,
            "primary_contact_name": null,
            "primary_contact_email": null,
            "primary_contact_phone": null,
            "metadata": null,
            "percentage_charge": 18.2,
            "is_verified": false,
            "settlement_bank": "Access Bank",
            "account_number": "0193274682",
            "settlement_schedule": "AUTO",
            "active": true,
            "migrate": false,
            "id": 55,
            "createdAt": "2016-10-05T13:22:04.000Z",
            "updatedAt": "2016-10-21T02:19:47.000Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/subaccount")
        .with(body: %({\
          "business_name":"Sunshine Studios",\
          "settlement_bank":"044",\
          "account_number":"0193274682",\
          "percentage_charge":18.2\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subaccounts.create(
        business_name: "Sunshine Studios",
        settlement_bank: "044",
        account_number: "0193274682",
        percentage_charge: 18.2
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Subaccount)
      end
    end
  end

  describe "#list" do
    it "lists subaccounts" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subaccounts retrieved",
          "data": [
            {
              "integration": 129938,
              "domain": "test",
              "subaccount_code": "ACCT_cljt3j4cp0kb2gq",
              "business_name": "Business 2",
              "description": null,
              "primary_contact_name": null,
              "primary_contact_email": null,
              "primary_contact_phone": null,
              "metadata": null,
              "percentage_charge": 20,
              "is_verified": false,
              "settlement_bank": "Zenith Bank",
              "account_number": "0193274382",
              "active": true,
              "migrate": false,
              "id": 53,
              "createdAt": "2016-10-05T12:55:47.000Z",
              "updatedAt": "2016-10-05T12:55:47.000Z"
            },
            {
              "integration": 129938,
              "domain": "test",
              "subaccount_code": "ACCT_vwy3d1gck2c9gxi",
              "business_name": "Sunshine Studios",
              "description": null,
              "primary_contact_name": null,
              "primary_contact_email": null,
              "primary_contact_phone": null,
              "metadata": null,
              "percentage_charge": 20,
              "is_verified": false,
              "settlement_bank": "Access Bank",
              "account_number": "0128633833",
              "active": true,
              "migrate": false,
              "id": 35,
              "createdAt": "2016-10-04T09:06:00.000Z",
              "updatedAt": "2016-10-04T09:06:00.000Z"
            }
          ],
          "meta": {
            "total": 20,
            "skipped": 0,
            "perPage": 3,
            "page": 1,
            "pageCount": 7
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/subaccount")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subaccounts.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Subaccount))
      end
    end
  end

  describe "#fetch" do
    it "fetches subaccount" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subaccount retrieved",
          "data": {
            "integration": 100973,
            "domain": "test",
            "subaccount_code": "ACCT_4hl4xenwpjy5wb",
            "business_name": "Sunshine Studios",
            "description": null,
            "primary_contact_name": null,
            "primary_contact_email": "dafe@aba.com",
            "primary_contact_phone": null,
            "metadata": null,
            "percentage_charge": 18.9,
            "is_verified": false,
            "settlement_bank": "Access Bank",
            "account_number": "0193274682",
            "settlement_schedule": "AUTO",
            "active": true,
            "migrate": false,
            "id": 55,
            "createdAt": "2016-10-05T13:22:04.000Z",
            "updatedAt": "2016-10-21T02:19:47.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/subaccount/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subaccounts.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Subaccount)
      end
    end
  end

  describe "#update" do
    it "updates subaccount" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subaccount updated",
          "data": {
            "integration": 100973,
            "domain": "test",
            "subaccount_code": "ACCT_4hl4xenwpjy5wb",
            "business_name": "Sunshine Studios",
            "description": null,
            "primary_contact_name": null,
            "primary_contact_email": "dafe@aba.com",
            "primary_contact_phone": null,
            "metadata": null,
            "percentage_charge": 18.9,
            "is_verified": false,
            "settlement_bank": "Access Bank",
            "account_number": "0193274682",
            "settlement_schedule": "AUTO",
            "active": true,
            "migrate": false,
            "id": 55,
            "createdAt": "2016-10-05T13:22:04.000Z",
            "updatedAt": "2016-10-21T02:19:47.000Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/subaccount/123456")
        .with(body: %({\
          "primary_contact_email":"dafe@aba.com",\
          "percentage_charge":18.9\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subaccounts.update(
        123456,
        primary_contact_email: "dafe@aba.com",
        percentage_charge: 18.9
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Subaccount)
      end
    end
  end
end
