require "../spec_helper"

describe Haystack::Customer do
  describe ".from_any" do
    it "returns customer unmodified" do
      id = 11
      customer = Haystack::Customer.from_json(%({"id": #{id}}))
      customer = Haystack::Customer.from_any(customer)

      customer.should be_a(Haystack::Customer)
      customer.try(&.id).should eq(id)
    end

    it "returns customer from integer" do
      id = 44
      customer = Haystack::Customer.from_any(id)

      customer.should be_a(Haystack::Customer)
      customer.try(&.id).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Customer.from_any(nil).should be_nil
    end
  end
end

describe Haystack::Customer::Endpoint do
  describe "#create" do
    it "creates customer" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customer created",
          "data": {
            "email": "customer@email.com",
            "integration": 100032,
            "domain": "test",
            "customer_code": "CUS_xnxdt6s1zg1f4nx",
            "id": 1173,
            "identified": false,
            "identifications":null,
            "createdAt": "2016-03-29T20:03:09.584Z",
            "updatedAt": "2016-03-29T20:03:09.584Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/customer")
        .with(body: %({"email":"customer@email.com"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.create(email: "customer@email.com") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Customer)
      end
    end
  end

  describe "#list" do
    it "lists customers" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customers retrieved",
          "data": [
            {
              "integration": 177932,
              "first_name": "Abc",
              "last_name": "Def",
              "email": "abc@def.com",
              "phone": "",
              "metadata": null,
              "domain": "test",
              "customer_code": "CUS_ucclia147ku0qrr",
              "risk_action": "default",
              "id": 48971448,
              "createdAt": "2021-07-05T14:29:33.000Z",
              "updatedAt": "2021-07-05T14:29:33.000Z"
            },
            {
              "integration": 177932,
              "first_name": null,
              "last_name": null,
              "email": "customer@email.com",
              "phone": null,
              "metadata": null,
              "domain": "test",
              "customer_code": "CUS_ickxv3gitt9mzou",
              "risk_action": "default",
              "id": 48204847,
              "createdAt": "2021-06-25T16:36:52.000Z",
              "updatedAt": "2021-06-25T16:36:52.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/customer")
        .with(query: {"perPage" => "20"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.list(perPage: "20") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Customer))
      end
    end
  end

  describe "#fetch" do
    it "fetches customer" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customer retrieved",
          "data": {
            "integration": 100032,
            "first_name": "Bojack",
            "last_name": "Horseman",
            "email": "bojack@horsinaround.com",
            "phone": null,
            "dedicated_account": {
              "bank": {
                "name": "Wema Bank",
                "id": 20,
                "slug": "wema-bank"
              },
              "id": 92747,
              "account_name": "PAYSTACKPAYME/ADEWUYI OLUGBENGA",
              "account_number": "7358520019",
              "created_at": "2021-02-09T09:13:49.000Z",
              "updated_at": "2021-02-09T09:13:49.000Z",
              "currency": "NGN",
              "split_config": {
                "id": 221,
                "name": "My Split",
                "type": "flat",
                "currency": "NGN",
                "integration": 100043,
                "domain": "live",
                "split_code": "SPL_goizzoc1rgizm53",
                "active": true,
                "bearer_type": "all",
                "bearer_subaccount": null,
                "createdAt": "2020-08-13T14:52:49.000Z",
                "updatedAt": "2020-08-13T14:52:49.000Z",
                "is_dynamic": true,
                "subaccounts": [
                  {
                    "subaccount": {
                      "id": 246,
                      "subaccount_code": "ACCT_lf61e3lk2dqqlg1",
                      "business_name": "Bami FB",
                      "description": "Bami FB",
                      "primary_contact_name": null,
                      "primary_contact_email": null,
                      "primary_contact_phone": null,
                      "metadata": null,
                      "settlement_bank": "First Bank of Nigeria",
                      "currency": "NGN",
                      "account_number": "3055740701"
                    },
                    "share": 20000
                  }
                ],
                "total_subaccounts": 1
              },
              "active": true,
              "assigned": true,
              "assignment": {
                "assignee_id": 973,
                "assignee_type": "Customer",
                "account_type": "PAY-WITH-TRANSFER-RECURRING",
                "integration": 100043
              }
            },
            "identified": true,
            "identifications": [
              {
                "country": "NG",
                "type": "bvn",
                "value": "223*****992"
              }
            ],
            "metadata": {
              "photos": [
                {
                  "type": "twitter",
                  "typeId": "twitter",
                  "typeName": "Twitter",
                  "url": "https://d2ojpxxtu63wzl.cloudfront.net/static/61b1a0a1d4dda2c9fe9e165fed07f812_a722ae7148870cc2e33465d1807dfdc6efca33ad2c4e1f8943a79eead3c21311",
                  "isPrimary": true
                }
              ]
            },
            "domain": "test",
            "customer_code": "CUS_xnxdt6s1zg1f4nx",
            "id": 1173,
            "transactions": [],
            "subscriptions": [],
            "authorizations": [],
            "createdAt": "2016-03-29T20:03:09.000Z",
            "updatedAt": "2016-03-29T20:03:10.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/customer/customer@email.com")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.fetch("customer@email.com") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Customer)
      end
    end
  end

  describe "#update" do
    it "updates customer" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customer updated",
          "data": {
            "integration": 100032,
            "first_name": "BoJack",
            "last_name": "Horseman",
            "email": "bojack@horsinaround.com",
            "phone": null,
            "metadata": {
              "photos": [
                {
                  "type": "twitter",
                  "typeId": "twitter",
                  "typeName": "Twitter",
                  "url": "https://d2ojpxxtu63wzl.cloudfront.net/static/61b1a0a1d4dda2c9fe9e165fed07f812_a722ae7148870cc2e33465d1807dfdc6efca33ad2c4e1f8943a79eead3c21311",
                  "isPrimary": true
                }
              ]
            },
            "identified": false,
            "identifications":null,
            "domain": "test",
            "customer_code": "CUS_xnxdt6s1zg1f4nx",
            "id": 1173,
            "transactions": [],
            "subscriptions": [],
            "authorizations": [],
            "createdAt": "2016-03-29T20:03:09.000Z",
            "updatedAt": "2016-03-29T20:03:10.000Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/customer/abc123")
        .with(body: %({"first_name":"BoJack"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.update("abc123", first_name: "BoJack") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Customer)
      end
    end
  end

  describe "#verify" do
    it "validates customer" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customer identified",
          "data": {
            "country": "NG",
            "type": "bvn",
            "value": "223*****992"
          }
        }
        JSON

      WebMock.stub(
        :post,
        "https://api.paystack.co/customer/abc123/identification"
      )
        .with(body: %({\
          "country":"NG",\
          "type":"bvn",\
          "value":"200123456677",\
          "first_name":"Asta",\
          "last_name":"Lavista"\
        }))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.verify(
        "abc123",
        country: "NG",
        type: "bvn",
        value: "200123456677",
        first_name: "Asta",
        last_name: "Lavista"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Customer::Identification)
      end
    end
  end

  describe "#set_risk_action" do
    it "sets risk action" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customer updated",
          "data": {
            "first_name": "Peter",
            "last_name": "Griffin",
            "email": "peter@familyguy.com",
            "phone": null,
            "metadata": {},
            "domain": "test",
            "identified": false,
            "identifications": null,
            "customer_code": "CUS_xr58yrr2ujlft9k",
            "risk_action": "allow",
            "id": 2109,
            "integration": 100032,
            "createdAt": "2016-01-26T13:43:38.000Z",
            "updatedAt": "2016-08-23T03:56:43.000Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/customer/set_risk_action")
        .with(body: %({"customer":"CUS_xr58yrr2ujlft9k","risk_action":"allow"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.set_risk_action(
        customer: "CUS_xr58yrr2ujlft9k",
        risk_action: "allow"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Customer)
      end
    end
  end

  describe "#deactivate_authorization" do
    it "deactivates authorization" do
      body = <<-JSON
        {
          "status": true,
          "message": "Authorization has been deactivated"
        }
        JSON

      WebMock.stub(
        :post,
        "https://api.paystack.co/customer/deactivate_authorization"
      )
        .with(body: %({"authorization_code":"AUTH_72btv547"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.customers.deactivate_authorization(
        authorization_code: "AUTH_72btv547"
      ) do |response|
        response.success?.should be_true
      end
    end
  end
end
