require "../spec_helper"

describe Haystack::Transaction do
  describe ".from_any" do
    it "returns transaction unmodified" do
      id = 11
      transaction = Haystack::Transaction.from_json(%({"id": #{id}}))
      transaction = Haystack::Transaction.from_any(transaction)

      transaction.should be_a(Haystack::Transaction)
      transaction.try(&.id).should eq(id)
    end

    it "returns transaction from integer" do
      id = 44
      transaction = Haystack::Transaction.from_any(id)

      transaction.should be_a(Haystack::Transaction)
      transaction.try(&.id).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Transaction.from_any(nil).should be_nil
    end
  end
end

describe Haystack::Transaction::Endpoint do
  describe "#init" do
    it "initializes transaction" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Authorization URL created",
          "data": {
            "authorization_url": "https://checkout.paystack.com/a1b2c3",
            "access_code": "a1b2c3",
            "reference": "def456"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transaction/initialize")
        .with(body: %({"email":"customer@email.com","amount":"20000"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.initiate(
        email: "customer@email.com",
        amount: "20000"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction::Authorization)
      end
    end
  end

  describe "#verify" do
    it "verifies transaction" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Verification successful",
          "data": {
            "id": 1189740452,
            "domain": "test",
            "status": "abandoned",
            "reference": "yyj9asumly",
            "amount": 20000,
            "message": null,
            "gateway_response": "The transaction was not completed",
            "paid_at": null,
            "created_at": "2021-06-25T19:26:48.000Z",
            "channel": "card",
            "currency": "GHS",
            "ip_address": "154.160.16.138, 162.158.158.247",
            "metadata": "",
            "log": null,
            "fees": null,
            "fees_split": null,
            "authorization": {},
            "customer": {
              "id": 48204847,
              "first_name": null,
              "last_name": null,
              "email": "customer@email.com",
              "customer_code": "CUS_ickxv3gitt9mzou",
              "phone": null,
              "metadata": null,
              "risk_action": "default",
              "international_format_phone": null
            },
            "plan": null,
            "split": {},
            "order_id": null,
            "paidAt": null,
            "createdAt": "2021-06-25T19:26:48.000Z",
            "requested_amount": 20000,
            "pos_transaction_data": null,
            "source": null,
            "transaction_date": "2021-06-25T19:26:48.000Z",
            "plan_object": {},
            "subaccount": {}
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transaction/verify/def456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.verify("def456") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#list" do
    it "lists transactions" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transactions retrieved",
          "data": [
            {
              "id": 1204411596,
              "domain": "test",
              "status": "success",
              "reference": "T998476328309401",
              "amount": 1000,
              "message": null,
              "gateway_response": "Successful",
              "paid_at": "2021-07-05T14:29:44.000Z",
              "created_at": "2021-07-05T14:29:33.000Z",
              "channel": "card",
              "currency": "GHS",
              "ip_address": "154.160.10.48",
              "metadata": {
                "custom_filters": {
                  "recurring": true
                },
                "referrer": "https://paystack.com/pay/2t7y66pd0a"
              },
              "log": {
                "start_time": 1625495374,
                "time_spent": 11,
                "attempts": 1,
                "errors": 0,
                "success": true,
                "mobile": false,
                "input": [],
                "history": [
                  {
                    "type": "action",
                    "message": "Attempted to pay with card",
                    "time": 10
                  },
                  {
                    "type": "success",
                    "message": "Successfully paid with card",
                    "time": 11
                  }
                ]
              },
              "fees": 20,
              "fees_split": null,
              "customer": {
                "id": 48971448,
                "first_name": "Abc",
                "last_name": "Def",
                "email": "abc@def.com",
                "phone": "",
                "metadata": null,
                "customer_code": "CUS_ucclia147ku0qrr",
                "risk_action": "default"
              },
              "authorization": {
                "authorization_code": "AUTH_rfi98ynpa6",
                "bin": "408408",
                "last4": "4081",
                "exp_month": "12",
                "exp_year": "2030",
                "channel": "card",
                "card_type": "visa ",
                "bank": "TEST BANK",
                "country_code": "GH",
                "brand": "visa",
                "reusable": true,
                "signature": "SIG_GYkNnkHX8msRBTrbbTjk",
                "account_name": null
              },
              "plan": {},
              "split": {},
              "subaccount": {},
              "order_id": null,
              "paidAt": "2021-07-05T14:29:44.000Z",
              "createdAt": "2021-07-05T14:29:33.000Z",
              "requested_amount": 1000,
              "source": {
                "source": "checkout",
                "type": "web",
                "identifier": null,
                "entry_point": "request_inline"
              },
              "pos_transaction_data": null
            },
            {
              "id": 1201999721,
              "domain": "test",
              "status": "abandoned",
              "reference": "w4u5tlu1ab",
              "amount": 20000,
              "message": null,
              "gateway_response": "The transaction was not completed",
              "paid_at": null,
              "created_at": "2021-07-03T20:22:39.000Z",
              "channel": "card",
              "currency": "GHS",
              "ip_address": "154.160.3.241, 141.101.99.253",
              "metadata": null,
              "log": null,
              "fees": null,
              "fees_split": null,
              "customer": {
                "id": 48204847,
                "first_name": null,
                "last_name": null,
                "email": "customer@email.com",
                "phone": null,
                "metadata": null,
                "customer_code": "CUS_ickxv3gitt9mzou",
                "risk_action": "default"
              },
              "authorization": {
                "authorization_code": null,
                "bin": null,
                "last4": null,
                "exp_month": null,
                "exp_year": null,
                "channel": null,
                "card_type": null,
                "bank": null,
                "country_code": null,
                "brand": null,
                "reusable": false,
                "signature": null,
                "account_name": null
              },
              "plan": {},
              "split": {},
              "subaccount": {},
              "order_id": null,
              "paidAt": null,
              "createdAt": "2021-07-03T20:22:39.000Z",
              "requested_amount": 20000,
              "source": {
                "source": "merchant_api",
                "type": "api",
                "identifier": null,
                "entry_point": "transaction_initialize"
              },
              "pos_transaction_data": null
            }
          ],
          "meta": {
            "total": 26,
            "total_volume": 4810,
            "skipped": 0,
            "perPage": 50,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transaction")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Transaction))
      end
    end
  end

  describe "#fetch" do
    it "fetches transaction" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transaction retrieved",
          "data": {
            "id": 1204411596,
            "domain": "test",
            "status": "success",
            "reference": "T998476328309401",
            "amount": 1000,
            "message": null,
            "gateway_response": "Successful",
            "paid_at": "2021-07-05T14:29:44.000Z",
            "created_at": "2021-07-05T14:29:33.000Z",
            "channel": "card",
            "currency": "GHS",
            "ip_address": "154.160.10.48",
            "metadata": {
              "custom_filters": {
                "recurring": true
              },
              "referrer": "https://paystack.com/pay/2t7y66pd0a"
            },
            "log": {
              "start_time": 1625495374,
              "time_spent": 11,
              "attempts": 1,
              "errors": 0,
              "success": true,
              "mobile": false,
              "input": [],
              "history": [
                {
                  "type": "action",
                  "message": "Attempted to pay with card",
                  "time": 10
                },
                {
                  "type": "success",
                  "message": "Successfully paid with card",
                  "time": 11
                }
              ]
            },
            "fees": 20,
            "fees_split": null,
            "authorization": {
              "authorization_code": "AUTH_rfi98ynpa6",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2030",
              "channel": "card",
              "card_type": "visa ",
              "bank": "TEST BANK",
              "country_code": "GH",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_GYkNnkHX8msRBTrbbTjk",
              "account_name": null,
              "receiver_bank_account_number": null,
              "receiver_bank": null
            },
            "customer": {
              "id": 48971448,
              "first_name": "Abc",
              "last_name": "Def",
              "email": "abc@def.com",
              "customer_code": "CUS_ucclia147ku0qrr",
              "phone": "",
              "metadata": null,
              "risk_action": "default",
              "international_format_phone": null
            },
            "plan": {
              "id": 122155,
              "name": "Plan 1",
              "plan_code": "PLN_b2oe6rbgt0d5r4l",
              "description": "Testing API",
              "amount": 1000,
              "interval": "hourly",
              "send_invoices": true,
              "send_sms": true,
              "currency": "GHS"
            },
            "subaccount": {},
            "split": {},
            "order_id": null,
            "paidAt": "2021-07-05T14:29:44.000Z",
            "createdAt": "2021-07-05T14:29:33.000Z",
            "requested_amount": 1000,
            "pos_transaction_data": null,
            "source": null
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transaction/292584114")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.fetch(292584114) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#charge_authorization" do
    it "charges authorization" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 20000,
            "currency": "NGN",
            "transaction_date": "2020-05-27T11:45:03.000Z",
            "status": "success",
            "reference": "cn65lf4ixmkzvda",
            "domain": "test",
            "metadata": "",
            "gateway_response": "Approved",
            "message": null,
            "channel": "card",
            "ip_address": null,
            "log": null,
            "fees": 14500,
            "authorization": {
              "authorization_code": "AUTH_pmx3mgawyd",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa DEBIT",
              "bank": "Test Bank",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_2Gvc6pNuzJmj4TCchXfp",
              "account_name": null
            },
            "customer": {
              "id": 23215815,
              "first_name": null,
              "last_name": null,
              "email": "mail@mail.com",
              "customer_code": "CUS_wt0zmhzb0xqd4nr",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null,
            "id": 696105928
          }
        }
        JSON

      WebMock.stub(
        :post,
        "https://api.paystack.co/transaction/charge_authorization"
      )
        .with(body: %({\
          "email":"customer@email.com",\
          "amount":"20000",\
          "authorization_code":"AUTH_72btv547"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.charge_authorization(
        email: "customer@email.com",
        amount: "20000",
        authorization_code: "AUTH_72btv547"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#check_authorization" do
    it "checks authorization" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Authorization is valid for this amount",
          "data": {
            "amount": 20000,
            "currency": "NGN"
          }
        }
        JSON

      WebMock.stub(
        :post,
        "https://api.paystack.co/transaction/check_authorization"
      )
        .with(body: %({\
          "email":"customer@email.com",\
          "amount":"20000",\
          "authorization_code":"AUTH_72btv547"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.check_authorization(
        email: "customer@email.com",
        amount: "20000",
        authorization_code: "AUTH_72btv547"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Amount)
      end
    end
  end

  describe "#timeline" do
    it "shows transaction timeline" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Timeline retrieved",
          "data": {
            "time_spent": 9061,
            "attempts": 1,
            "authentication": null,
            "errors": 1,
            "success": false,
            "mobile": false,
            "input": [],
            "channel": "card",
            "history": [
              {
                "type": "open",
                "message": "Opened payment page",
                "time": 1
              },
              {
                "type": "input",
                "message": "Filled these fields: card number, card expiry, card cvc",
                "time": 39
              }
            ]
          }
        }
        JSON

      WebMock.stub(
        :get,
        "https://api.paystack.co/transaction/timeline/292584114"
      ).to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.timeline(292584114) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Log)
      end
    end
  end

  describe "#totals" do
    it "shows transaction totals" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transaction totals",
          "data": {
            "total_transactions": 10,
            "unique_customers": 3,
            "total_volume": 14000,
            "total_volume_by_currency": [
              {
                "currency": "NGN",
                "amount": 14000
              }
            ],
            "pending_transfers": 24000,
            "pending_transfers_by_currency": [
              {
                "currency": "NGN",
                "amount": 24000
              }
            ]
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transaction/totals")
        .with(query: {"page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.totals(page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction::Totals)
      end
    end
  end

  describe "#export" do
    it "exports transactions" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Export successful",
          "data": {
            "path": "https://files.paystack.co/exports/100032/1460290758207.csv"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transaction/export")
        .with(query: {"page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.export(page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Export)
      end
    end
  end

  describe "#debit" do
    it "retrieves part payment" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 2000,
            "currency": "NGN",
            "transaction_date": "2020-01-23T14:39:37.000Z",
            "status": "success",
            "reference": "REF_0000000001",
            "domain": "test",
            "metadata": "",
            "gateway_response": "Approved",
            "message": null,
            "channel": "card",
            "ip_address": null,
            "log": null,
            "fees": 30,
            "authorization": {
              "authorization_code": "AUTH_72btv547",
              "bin": "408408",
              "last4": "0409",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa DEBIT",
              "bank": "Test Bank",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_GfJIf2Dg1N1BwN5ddXmh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 16702,
              "first_name": "",
              "last_name": "",
              "email": "customer@email.com",
              "customer_code": "CUS_096t7vsogztygg4",
              "phone": "",
              "metadata": null,
              "risk_action": "default"
            },
            "plan": 0,
            "amount": 2000
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transaction/partial_debit")
        .with(body: %({\
          "authorization_code":"AUTH_72btv547",\
          "currency":"NGN",\
          "amount":"20000",\
          "email":"customer@email.com"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transactions.debit(
        authorization_code: "AUTH_72btv547",
        currency: "NGN",
        amount: "20000",
        email: "customer@email.com"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end
end
