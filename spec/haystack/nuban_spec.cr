require "../spec_helper"

describe Haystack::Nuban::Endpoint do
  describe "#create" do
    it "creates dedicated NUBAN account" do
      body = <<-JSON
        {
          "status": true,
          "message": "NUBAN successfully created",
          "data": {
            "bank": {
              "name": "Wema Bank",
              "id": 20,
              "slug": "wema-bank"
            },
            "account_name": "KAROKART / RHODA CHURCH",
            "account_number": "9930000737",
            "assigned": true,
            "currency": "NGN",
            "metadata": null,
            "active": true,
            "id": 253,
            "created_at": "2019-12-12T12:39:04.000Z",
            "updated_at": "2020-01-06T15:51:24.000Z",
            "assignment": {
              "integration": 100043,
              "assignee_id": 7454289,
              "assignee_type": "Customer",
              "expired": false,
              "account_type": "PAY-WITH-TRANSFER-RECURRING",
              "assigned_at": "2020-01-06T15:51:24.764Z"
            },
            "customer": {
              "id": 7454289,
              "first_name": "RHODA",
              "last_name": "CHURCH",
              "email": "rhodachurch@email.com",
              "customer_code": "CUS_kpb3qj71u1m0rw8",
              "phone": "+2349053267565",
              "risk_action": "default"
            }
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/dedicated_account")
        .with(body: %({"customer":481193,"preferred_bank":"wema-bank"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.create(
        customer: 481193,
        preferred_bank: "wema-bank"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Bank::Account)
      end
    end
  end

  describe "#list" do
    it "lists dedicated NUBAN accounts" do
      body = <<-JSON
        {
          "status": true,
          "message": "Managed accounts successfully retrieved",
          "data": [{
            "customer": {
              "id": 1530104,
              "first_name": "yinka",
              "last_name": "Ojo",
              "email": "hello@company.co",
              "customer_code": "CUS_dy1r7ts03zixbq5",
              "phone": "08154239386",
              "risk_action": "default",
              "international_format_phone": null
            },
            "bank": {
              "name": "Wema Bank",
              "id": 20,
              "slug": "wema-bank"
            },
            "id": 173,
            "account_name": "KAROKART/A YINKA",
            "account_number": "9930020212",
            "created_at": "2019-12-09T13:31:38.000Z",
            "updated_at": "2020-06-11T14:04:28.000Z",
            "currency": "NGN",
            "split_config": {
              "subaccount": "ACCT_xdrne0tcvr5jkei"
            },
            "active": true,
            "assigned": true
          }],
          "meta": {
            "total": 1,
            "skipped": 0,
            "perPage": 50,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/dedicated_account")
        .with(query: {"active" => "true", "currency" => "USD"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.list(active: "true", currency: "USD") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Bank::Account))
      end
    end
  end

  describe "#fetch" do
    it "fetches dedicated NUBAN account" do
      body = <<-JSON
        {
          "status": true,
          "message": "Customer retrieved",
          "data": {
            "transactions": [],
            "subscriptions": [],
            "authorizations": [],
            "first_name": null,
            "last_name": null,
            "email": "hello@paystack.com",
            "phone": null,
            "metadata": null,
            "domain": "live",
            "customer_code": "CUS_h00a7ngn0xbzf2g",
            "risk_action": "default",
            "id": 17593,
            "integration": 190972,
            "createdAt": "2019-10-25T15:05:23.000Z",
            "updatedAt": "2019-10-25T15:05:23.000Z",
            "created_at": "2019-10-25T15:05:23.000Z",
            "updated_at": "2019-10-25T15:05:23.000Z",
            "total_transactions": 0,
            "total_transaction_value": [],
            "dedicated_account": {
              "id": 59,
              "account_name": "KAROKART/RHODA CHURCH",
              "account_number": "9807062474",
              "created_at": "2019-09-10T11:10:12.000Z",
              "updated_at": "2019-10-25T15:05:24.000Z",
              "currency": "NGN",
              "active": true,
              "assigned": true,
              "provider": {
                "id": 1,
                "provider_slug": "wema-bank",
                "bank_id": 20,
                "bank_name": "Wema Bank"
              },
              "assignment": {
                "assignee_id": 17593,
                "assignee_type": "Customer",
                "account_type": "PAY-WITH-TRANSFER-RECURRING",
                "integration": 190972
              }
            }
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/dedicated_account/123456")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Customer)
      end
    end
  end

  describe "#deactivate" do
    it "deactivates dedicated NUBAN account" do
      body = <<-JSON
        {
          "status": true,
          "message": "Managed Account Successfully Unassigned",
          "data": {
            "bank": {
              "name": "Wema Bank",
              "id": 20,
              "slug": "wema-bank"
            },
            "account_name": "KAROKART/A YINKA",
            "account_number": "9930020212",
            "assigned": false,
            "currency": "NGN",
            "metadata": null,
            "active": true,
            "id": 173,
            "created_at": "2019-12-09T13:31:38.000Z",
            "updated_at": "2020-08-28T10:04:25.000Z",
            "assignment": {
              "assignee_id": 1530104,
              "assignee_type": "Integration",
              "assigned_at": "2019-12-09T13:40:21.000Z",
              "integration": 100043,
              "account_type": "PAY-WITH-TRANSFER-RECURRING"
            }
          }
        }
        JSON

      WebMock.stub(:delete, "https://api.paystack.co/dedicated_account/123456")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.deactivate(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Bank::Account)
      end
    end
  end

  describe "#split" do
    it "splits dedicated NUBAN account" do
      body = <<-JSON
        {
          "status": true,
          "message": "Assigned Managed Account Successfully Created",
          "data": {
            "bank": {
              "name": "Wema Bank",
              "id": 20,
              "slug": "wema-bank"
            },
            "account_name": "KAROKART/YINKA ADE",
            "account_number": "6731105168",
            "assigned": true,
            "currency": "NGN",
            "metadata": null,
            "active": true,
            "id": 97,
            "created_at": "2019-11-13T13:52:39.000Z",
            "updated_at": "2020-03-17T07:52:23.000Z",
            "assignment": {
              "integration": 100043,
              "assignee_id": 17328,
              "assignee_type": "Customer",
              "expired": false,
              "account_type": "PAY-WITH-TRANSFER-RECURRING",
              "assigned_at": "2020-03-17T07:52:23.023Z",
              "expired_at": null
            },
            "split_config": {"split_code":"SPL_e7jnRLtzla"},
            "customer": {
              "id": 17328,
              "first_name": "YINKA",
              "last_name": "ADE",
              "email": "yinka@testemail.com",
              "customer_code": "CUS_xxxxxxxx",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            }
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/dedicated_account/split")
        .with(body: %({\
          "customer":481193,\
          "preferred_bank":"wema-bank",\
          "split_code":"SPL_e7jnRLtzla"\
        }))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.split(
        customer: 481193,
        preferred_bank: "wema-bank",
        split_code: "SPL_e7jnRLtzla"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Bank::Account)
      end
    end
  end

  describe "#unsplit" do
    it "unsplits dedicated NUBAN account" do
      body = <<-JSON
        {
          "status": true,
          "message": "Subaccount unassigned",
          "data": {
            "id": 22173,
            "split_config": null,
            "account_name": "KAROKART/YINKA ADE",
            "account_number": "0033322211",
            "currency": "NGN",
            "assigned": true,
            "active": true,
            "createdAt": "2020-03-11T15:14:00.707Z",
            "updatedAt": "2020-03-11T15:14:00.707Z"
          }
        }
        JSON

      WebMock.stub(:delete, "https://api.paystack.co/dedicated_account/split")
        .with(body: %({"account_number":"0033322211"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.unsplit(account_number: "0033322211") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Bank::Account)
      end
    end
  end

  describe "#providers" do
    it "lists providers for dedicated NUBAN account" do
      body = <<-JSON
        {
          "status": true,
          "message": "Dedicated account providers retrieved",
          "data": [
            {
              "provider_slug": "access-bank",
              "bank_id": 1,
              "bank_name": "Access Bank",
              "id": 6
            },
            {
              "provider_slug": "wema-bank",
              "bank_id": 20,
              "bank_name": "Wema Bank",
              "id": 5
            }
          ]
        }
        JSON

      WebMock.stub(
        :get,
        "https://api.paystack.co/dedicated_account/available_providers"
      ).to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.nubans.providers do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Bank::Provider))
      end
    end
  end
end
