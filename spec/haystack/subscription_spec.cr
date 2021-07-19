require "../spec_helper"

describe Haystack::Subscription do
  describe ".from_any" do
    it "returns subscription unmodified" do
      id = 11
      subscription = Haystack::Subscription.from_json(%({"id": #{id}}))
      subscription = Haystack::Subscription.from_any(subscription)

      subscription.should be_a(Haystack::Subscription)
      subscription.try(&.id).should eq(id)
    end

    it "returns subscription from integer" do
      id = 44
      subscription = Haystack::Subscription.from_any(id)

      subscription.should be_a(Haystack::Subscription)
      subscription.try(&.id).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Subscription.from_any(nil).should be_nil
    end
  end
end

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
              "id": 278858,
              "domain": "test",
              "status": "attention",
              "start": 1625495385,
              "quantity": 1,
              "subscription_code": "SUB_3nyia87c7negeop",
              "email_token": "7jnb54drgapxt16",
              "amount": 1000,
              "cron_expression": "0 * * * *",
              "next_payment_date": "2021-07-08T20:00:01.000Z",
              "open_invoice": null,
              "createdAt": "2021-07-05T14:29:45.000Z",
              "integration": 177932,
              "plan": {
                "id": 122155,
                "name": "Plan 1",
                "description": "Testing API",
                "amount": 1000,
                "interval": "hourly",
                "send_invoices": 1,
                "send_sms": 1,
                "currency": "GHS"
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
                "reusable": 1,
                "signature": "SIG_GYkNnkHX8msRBTrbbTjk",
                "account_name": null
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
              "invoice_limit": 0,
              "split_code": null,
              "payments_count": 1,
              "most_recent_invoice": {
                "subscription": 278858,
                "integration": 177932,
                "domain": "test",
                "invoice_code": "INV_hfimz59l9864fd7",
                "customer": 48971448,
                "transaction": 1209381156,
                "amount": 1000,
                "period_start": "2021-07-08T19:00:00.000Z",
                "period_end": "2021-07-08T19:59:59.000Z",
                "status": "failed",
                "paid": 0,
                "retries": 1,
                "authorization": {},
                "paid_at": null,
                "next_notification": "2021-07-05T19:59:59.000Z",
                "notification_flag": null,
                "description": null,
                "id": 3649162,
                "created_at": "2021-07-08T19:00:06.000Z",
                "updated_at": "2021-07-08T19:00:11.000Z"
              }
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
