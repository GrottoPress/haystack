require "../spec_helper"

describe Haystack::Subscription::Endpoint do
  describe "#create" do
    it "creates subscription" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subscription successfully created",
          "data": {
            "customer": 1173,
            "plan": 28,
            "integration": 100032,
            "domain": "test",
            "start": 1459296064,
            "status": "active",
            "quantity": 1,
            "amount": 50000,
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
            "subscription_code": "SUB_vsyqdmlzble3uii",
            "email_token": "d7gofp6yppn3qz7",
            "id": 9,
            "createdAt": "2016-03-30T00:01:04.687Z",
            "updatedAt": "2016-03-30T00:01:04.687Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/subscription")
        .with(body: %({\
          "customer":"CUS_xnxdt6s1zg1f4nx",\
          "plan":"PLN_gx2wn530m0i3w3m"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subscriptions.create(
        customer: "CUS_xnxdt6s1zg1f4nx",
        plan: "PLN_gx2wn530m0i3w3m"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Subscription)
      end
    end
  end

  describe "#list" do
    it "lists subscriptions" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subscriptions retrieved",
          "data": [
            {
              "customer": {
                "first_name": "BoJack",
                "last_name": "Horseman",
                "email": "bojack@horseman.com",
                "phone": "",
                "metadata": null,
                "domain": "test",
                "customer_code": "CUS_hdhye17yj8qd2tx",
                "risk_action": "default",
                "id": 84312,
                "integration": 100073,
                "createdAt": "2016-10-01T10:59:52.000Z",
                "updatedAt": "2016-10-01T10:59:52.000Z"
              },
              "plan": {
                "domain": "test",
                "name": "Weekly small chops",
                "plan_code": "PLN_0as2m9n02cl0kp6",
                "description": "Small chops delivered every week",
                "amount": 27000,
                "interval": "weekly",
                "send_invoices": true,
                "send_sms": true,
                "hosted_page": false,
                "hosted_page_url": null,
                "hosted_page_summary": null,
                "currency": "NGN",
                "migrate": null,
                "id": 1716,
                "integration": 100073,
                "createdAt": "2016-10-01T10:59:11.000Z",
                "updatedAt": "2016-10-01T10:59:11.000Z"
              },
              "integration": 123456,
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
              "domain": "test",
              "start": 1475319599,
              "status": "active",
              "quantity": 1,
              "amount": 27000,
              "subscription_code": "SUB_6phdx225bavuwtb",
              "email_token": "ore84lyuwcv2esu",
              "easy_cron_id": "275226",
              "cron_expression": "0 0 * * 6",
              "next_payment_date": "2016-10-15T00:00:00.000Z",
              "open_invoice": "INV_qc875pkxpxuyodf",
              "id": 4192,
              "createdAt": "2016-10-01T10:59:59.000Z",
              "updatedAt": "2016-10-12T07:45:14.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/subscription")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subscriptions.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Subscription))
      end
    end
  end

  describe "#fetch" do
    it "fetches subscription" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subscription retrieved successfully",
          "data": {
            "invoices": [],
            "customer": {
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
                    "isPrimary": false
                  }
                ]
              },
              "domain": "test",
              "customer_code": "CUS_xnxdt6s1zg1f4nx",
              "id": 1173,
              "integration": 100032,
              "createdAt": "2016-03-29T20:03:09.000Z",
              "updatedAt": "2016-03-29T20:53:05.000Z"
            },
            "plan": {
              "domain": "test",
              "name": "Monthly retainer (renamed)",
              "plan_code": "PLN_gx2wn530m0i3w3m",
              "description": null,
              "amount": 50000,
              "interval": "monthly",
              "send_invoices": true,
              "send_sms": true,
              "hosted_page": false,
              "hosted_page_url": null,
              "hosted_page_summary": null,
              "currency": "NGN",
              "id": 28,
              "integration": 100032,
              "createdAt": "2016-03-29T22:42:50.000Z",
              "updatedAt": "2016-03-29T23:51:41.000Z"
            },
            "integration": 100032,
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
            "domain": "test",
            "start": 1459296064,
            "status": "active",
            "quantity": 1,
            "amount": 50000,
            "subscription_code": "SUB_vsyqdmlzble3uii",
            "email_token": "d7gofp6yppn3qz7",
            "easy_cron_id": null,
            "cron_expression": "0 0 28 * *",
            "next_payment_date": "2016-04-28T07:00:00.000Z",
            "open_invoice": null,
            "id": 9,
            "createdAt": "2016-03-30T00:01:04.000Z",
            "updatedAt": "2016-03-30T00:22:58.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/subscription/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subscriptions.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Subscription)
      end
    end
  end

  describe "#enable" do
    it "enables subscription" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subscription enabled successfully"
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/subscription/enable")
        .with(body: %({"code":"SUB_vsyqdmlzble3uii","token":"d7gofp6yppn3qz7"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subscriptions.enable(
        code: "SUB_vsyqdmlzble3uii",
        token: "d7gofp6yppn3qz7"
      ) do |response|
        response.success?.should be_true
      end
    end
  end

  describe "#disable" do
    it "disables subscription" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subscription disabled successfully"
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/subscription/disable")
        .with(body: %({"code":"SUB_vsyqdmlzble3uii","token":"d7gofp6yppn3qz7"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.subscriptions.disable(
        code: "SUB_vsyqdmlzble3uii",
        token: "d7gofp6yppn3qz7"
      ) do |response|
        response.success?.should be_true
      end
    end
  end
end
