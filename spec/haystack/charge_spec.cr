require "../spec_helper"

describe Haystack::Charge::Endpoint do
  describe "#create" do
    it "creates charge" do
      body = <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 200,
            "currency": "NGN",
            "transaction_date": "2017-05-24T05:56:12.000Z",
            "status": "success",
            "reference": "zuvbpizfcf2fs7y",
            "domain": "test",
            "metadata": {
              "custom_fields": [
                {
                  "display_name":"Merchant name",
                  "variable_name":"merchant_name",
                  "value":"Van Damme"
                },
                {
                  "display_name":"Paid Via",
                  "variable_name":"paid_via",
                  "value":"API call"
                }
              ]
            },
            "gateway_response": "Successful",
            "message": null,
            "channel": "card",
            "ip_address": "54.154.89.28, 162.158.38.82, 172.31.38.35",
            "log": null,
            "fees": 3,
            "authorization": {
              "authorization_code": "AUTH_6tmt288t0o",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa visa",
              "bank": "TEST BANK",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_uSYN4fv1adlAuoij8QXh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 14571,
              "first_name": null,
              "last_name": null,
              "email": "ibrahim@paystack.co",
              "customer_code": "CUS_hns72vhhtos0f0k",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/charge")
        .with(body: %({"email":"customer@email.com","amount":"20000"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.create(
        email: "customer@email.com",
        amount: "20000"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#submit_pin" do
    it "submits pin" do
      body = <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 200,
            "currency": "NGN",
            "transaction_date": "2017-05-24T05:56:12.000Z",
            "status": "success",
            "reference": "zuvbpizfcf2fs7y",
            "domain": "test",
            "metadata": {
              "custom_fields": [
                {
                  "display_name":"Merchant name",
                  "variable_name":"merchant_name",
                  "value":"Van Damme"
                },
                {
                  "display_name":"Paid Via",
                  "variable_name":"paid_via",
                  "value":"API call"
                }
              ]
            },
            "gateway_response": "Successful",
            "message": null,
            "channel": "card",
            "ip_address": "54.154.89.28, 162.158.38.82, 172.31.38.35",
            "log": null,
            "fees": 3,
            "authorization": {
              "authorization_code": "AUTH_6tmt288t0o",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa visa",
              "bank": "TEST BANK",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_uSYN4fv1adlAuoij8QXh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 14571,
              "first_name": null,
              "last_name": null,
              "email": "ibrahim@paystack.co",
              "customer_code": "CUS_hns72vhhtos0f0k",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/charge/submit_pin")
        .with(body: %({"pin":"1234","reference":"5bwib5v6anhe9xa"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.submit_pin(
        pin: "1234",
        reference: "5bwib5v6anhe9xa"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#submit_otp" do
    it "submits otp" do
      body = <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 200,
            "currency": "NGN",
            "transaction_date": "2017-05-24T05:56:12.000Z",
            "status": "success",
            "reference": "zuvbpizfcf2fs7y",
            "domain": "test",
            "metadata": {
              "custom_fields": [
                {
                  "display_name":"Merchant name",
                  "variable_name":"merchant_name",
                  "value":"Van Damme"
                },
                {
                  "display_name":"Paid Via",
                  "variable_name":"paid_via",
                  "value":"API call"
                }
              ]
            },
            "gateway_response": "Successful",
            "message": null,
            "channel": "card",
            "ip_address": "54.154.89.28, 162.158.38.82, 172.31.38.35",
            "log": null,
            "fees": 3,
            "authorization": {
              "authorization_code": "AUTH_6tmt288t0o",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa visa",
              "bank": "TEST BANK",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_uSYN4fv1adlAuoij8QXh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 14571,
              "first_name": null,
              "last_name": null,
              "email": "ibrahim@paystack.co",
              "customer_code": "CUS_hns72vhhtos0f0k",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/charge/submit_otp")
        .with(body: %({"otp":"123456","reference":"5bwib5v6anhe9xa"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.submit_otp(
        otp: "123456",
        reference: "5bwib5v6anhe9xa"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#submit_phone" do
    it "submits phone" do
      body = <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 200,
            "currency": "NGN",
            "transaction_date": "2017-05-24T05:56:12.000Z",
            "status": "success",
            "reference": "zuvbpizfcf2fs7y",
            "domain": "test",
            "metadata": {
              "custom_fields": [
                {
                  "display_name":"Merchant name",
                  "variable_name":"merchant_name",
                  "value":"Van Damme"
                },
                {
                  "display_name":"Paid Via",
                  "variable_name":"paid_via",
                  "value":"API call"
                }
              ]
            },
            "gateway_response": "Successful",
            "message": null,
            "channel": "card",
            "ip_address": "54.154.89.28, 162.158.38.82, 172.31.38.35",
            "log": null,
            "fees": 3,
            "authorization": {
              "authorization_code": "AUTH_6tmt288t0o",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa visa",
              "bank": "TEST BANK",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_uSYN4fv1adlAuoij8QXh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 14571,
              "first_name": null,
              "last_name": null,
              "email": "ibrahim@paystack.co",
              "customer_code": "CUS_hns72vhhtos0f0k",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/charge/submit_phone")
        .with(body: %({"phone":"08012345678","reference":"5bwib5v6anhe9xa"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.submit_phone(
        phone: "08012345678",
        reference: "5bwib5v6anhe9xa"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#submit_birthday" do
    it "submits birthday" do
      body = <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 200,
            "currency": "NGN",
            "transaction_date": "2017-05-24T05:56:12.000Z",
            "status": "success",
            "reference": "zuvbpizfcf2fs7y",
            "domain": "test",
            "metadata": {
              "custom_fields":[
                {
                  "display_name":"Merchant name",
                  "variable_name":"merchant_name",
                  "value":"Van Damme"
                },
                {
                  "display_name":"Paid Via",
                  "variable_name":"paid_via",
                  "value":"API call"
                }
              ]
            },
            "gateway_response": "Successful",
            "message": null,
            "channel": "card",
            "ip_address": "54.154.89.28, 162.158.38.82, 172.31.38.35",
            "log": null,
            "fees": 3,
            "authorization": {
              "authorization_code": "AUTH_6tmt288t0o",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa visa",
              "bank": "TEST BANK",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_uSYN4fv1adlAuoij8QXh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 14571,
              "first_name": null,
              "last_name": null,
              "email": "ibrahim@paystack.co",
              "customer_code": "CUS_hns72vhhtos0f0k",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/charge/submit_birthday")
        .with(body: %({"birthday":"1961-09-21","reference":"5bwib5v6anhe9xa"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.submit_birthday(
        birthday: "1961-09-21",
        reference: "5bwib5v6anhe9xa"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#submit_address" do
    it "submits address" do
      body = <<-JSON
        {
          "message": "Charge attempted",
          "status": true,
          "data": {
            "message": "",
            "paidAt": "2020-05-21T15:16:00.000Z",
            "plan": null,
            "log": null,
            "ip_address": "35.177.113.19",
            "createdAt": "2020-05-21T15:14:25.000Z",
            "domain": "live",
            "fees": 390,
            "metadata": "",
            "requested_amount": 10000,
            "id": 102039,
            "currency": "NGN",
            "status": "success",
            "transaction_date": "2020-05-21T15:14:25.000Z",
            "reference": "7c7rpkqpc0tijs8",
            "subaccount": {},
            "customer": {
              "email": "femi@paystack.com",
              "last_name": "ALUKO",
              "metadata": null,
              "customer_code": "CUS_bpy9ciomcstg55y",
              "risk_action": "default",
              "first_name": "FEMI",
              "phone": "",
              "id": 16200
            },
            "order_id": null,
            "plan_object": {},
            "authorization": {
              "signature": "SIG_5wBvKoAT64nwSJgZkHvQ",
              "authorization_code": "AUTH_82e26bc6yb",
              "reusable": true,
              "exp_month": "08",
              "card_type": "visa DEBIT",
              "last4": "4633",
              "account_name": null,
              "channel": "card",
              "brand": "visa",
              "country_code": "US",
              "bin": "440066",
              "bank": "",
              "exp_year": "2024",
              "account_name": "BoJack Horseman"
            },
            "channel": "card",
            "amount": 10000,
            "created_at": "2020-05-21T15:14:25.000Z",
            "gateway_response": "Approved",
            "fees_split": null,
            "paid_at": "2020-05-21T15:16:00.000Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/charge/submit_address")
        .with(body: %({"address":"140 N 2ND ST","reference":"5bwib5v6anhe9xa"}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.submit_address(
        address: "140 N 2ND ST",
        reference: "5bwib5v6anhe9xa"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end

  describe "#check_status" do
    it "checks status" do
      body = <<-JSON
        {
          "status": true,
          "message": "Charge attempted",
          "data": {
            "amount": 200,
            "currency": "NGN",
            "transaction_date": "2017-05-24T05:56:12.000Z",
            "status": "success",
            "reference": "zuvbpizfcf2fs7y",
            "domain": "test",
            "metadata": {
              "custom_fields":[
                {
                  "display_name":"Merchant name",
                  "variable_name":"merchant_name",
                  "value":"Van Damme"
                },
                {
                  "display_name":"Paid Via",
                  "variable_name":"paid_via",
                  "value":"API call"
                }
              ]
            },
            "gateway_response": "Successful",
            "message": null,
            "channel": "card",
            "ip_address": "54.154.89.28, 162.158.38.82, 172.31.38.35",
            "log": null,
            "fees": 3,
            "authorization": {
              "authorization_code": "AUTH_6tmt288t0o",
              "bin": "408408",
              "last4": "4081",
              "exp_month": "12",
              "exp_year": "2020",
              "channel": "card",
              "card_type": "visa visa",
              "bank": "TEST BANK",
              "country_code": "NG",
              "brand": "visa",
              "reusable": true,
              "signature": "SIG_uSYN4fv1adlAuoij8QXh",
              "account_name": "BoJack Horseman"
            },
            "customer": {
              "id": 14571,
              "first_name": null,
              "last_name": null,
              "email": "ibrahim@paystack.co",
              "customer_code": "CUS_hns72vhhtos0f0k",
              "phone": null,
              "metadata": null,
              "risk_action": "default"
            },
            "plan": null
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/charge/zuvbpizfcf2fs7y")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.charges.check_status("zuvbpizfcf2fs7y") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transaction)
      end
    end
  end
end
