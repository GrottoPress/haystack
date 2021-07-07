require "../spec_helper"

describe Haystack::Plan::Endpoint do
  describe "#create" do
    it "creates plan" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Plan created",
          "data": {
            "name": "Monthly retainer",
            "amount": 500000,
            "interval": "monthly",
            "integration": 100032,
            "domain": "test",
            "plan_code": "PLN_gx2wn530m0i3w3m",
            "send_invoices": true,
            "send_sms": true,
            "hosted_page": false,
            "currency": "NGN",
            "id": 28,
            "createdAt": "2016-03-29T22:42:50.811Z",
            "updatedAt": "2016-03-29T22:42:50.811Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/plan")
        .with(body: %({\
          "name":"Monthly retainer",\
          "interval":"monthly",\
          "amount":"500000"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.plans.create(
        name: "Monthly retainer",
        interval: "monthly",
        amount: "500000"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Plan)
      end
    end
  end

  describe "#list" do
    it "lists plans" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Plans retrieved",
          "data": [
            {
              "subscriptions": [
                {
                  "customer": 63,
                  "plan": 27,
                  "integration": 100032,
                  "domain": "test",
                  "start": 1458505748,
                  "status": "complete",
                  "quantity": 1,
                  "amount": 100000,
                  "subscription_code": "SUB_birvokwpp0sftun",
                  "email_token": "9y62mxp4uh25das",
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
                  "easy_cron_id": null,
                  "cron_expression": "0 0 * * 0",
                  "next_payment_date": "2016-03-27T07:00:00.000Z",
                  "open_invoice": null,
                  "id": 8,
                  "createdAt": "2016-03-20T20:29:08.000Z",
                  "updatedAt": "2016-03-22T16:23:52.000Z"
                }
              ],
              "integration": 100032,
              "domain": "test",
              "name": "Satin Flower",
              "plan_code": "PLN_lkozbpsoyd4je9t",
              "description": null,
              "amount": 100000,
              "interval": "weekly",
              "send_invoices": true,
              "send_sms": true,
              "hosted_page": false,
              "hosted_page_url": null,
              "hosted_page_summary": null,
              "currency": "NGN",
              "id": 27,
              "createdAt": "2016-03-21T02:44:14.000Z",
              "updatedAt": "2016-03-21T02:44:14.000Z"
            },
            {
              "subscriptions": [],
              "integration": 100032,
              "domain": "test",
              "name": "Monthly retainer",
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
              "createdAt": "2016-03-29T22:42:50.000Z",
              "updatedAt": "2016-03-29T22:42:50.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/plan")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.plans.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Plan))
      end
    end
  end

  describe "#fetch" do
    it "fetches plan" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Plan retrieved",
          "data": {
            "subscriptions": [],
            "integration": 100032,
            "domain": "test",
            "name": "Monthly retainer",
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
            "id": 123456,
            "createdAt": "2016-03-29T22:42:50.000Z",
            "updatedAt": "2016-03-29T22:42:50.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/plan/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.plans.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Plan)
      end
    end
  end

  describe "#update" do
    it "updates plan" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Plan updated. 1 subscription(s) affected"
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/plan/123456")
        .with(body: %({"name":"Weekly retainer"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.plans.update(123456, name: "Weekly retainer") do |response|
        response.success?.should be_true
      end
    end
  end
end
