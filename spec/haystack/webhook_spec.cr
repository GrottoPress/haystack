require "../spec_helper"

describe Haystack::Webhook::Handler do
  it "skips if request method is not 'POST'" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "customeridentification.success",
        "data": {
          "customer_id": "9387490384",
          "customer_code": "CUS_xnxdt6s1zg1f4nx",
          "email": "bojack@horsinaround.com",
          "identification": {
            "country": "NG",
            "type": "bvn",
            "value": "200*****677"
          }
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("GET", "#{path}?a=b", headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context)

    context.response.status_code.should eq(404)
  end

  it "skips if request path does not match" do
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "customeridentification.success",
        "data": {
          "customer_id": "9387490384",
          "customer_code": "CUS_xnxdt6s1zg1f4nx",
          "email": "bojack@horsinaround.com",
          "identification": {
            "country": "NG",
            "type": "bvn",
            "value": "200*****677"
          }
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", "/webhooks/paystack/", headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, "/webhooks/paystack").call(context)

    context.response.status_code.should eq(404)
  end

  it "rejects unverified requests" do
    path = "/webhooks/paystack"

    body = <<-JSON
      {
        "event": "customeridentification.success",
        "data": {
          "customer_id": "9387490384",
          "customer_code": "CUS_xnxdt6s1zg1f4nx",
          "email": "bojack@horsinaround.com",
          "identification": {
            "country": "NG",
            "type": "bvn",
            "value": "200*****677"
          }
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, "ghijkl", body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new("abcdef", path).call(context)

    context.response.status_code.should eq(403)
  end

  it "handles customeridentification events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "customeridentification.failed",
        "data": {
          "customer_id": "9387490384",
          "customer_code": "CUS_xnxdt6s1zg1f4nx",
          "email": "bojack@horsinaround.com",
          "identification": {
            "country": "NG",
            "type": "bvn",
            "value": "200*****677"
          }
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(1)
    context.response.status_code.should eq(200)
  end

  it "handles dispute events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event":"charge.dispute.remind",
        "data":{
          "id":358950,
          "refund_amount":5800,
          "currency":"NGN",
          "status":"awaiting-merchant-feedback",
          "resolution":null,
          "domain":"live",
          "transaction":{
            "id":896467688,
            "domain":"live",
            "status":"success",
            "reference":"v3mjfgbnc19v97x",
            "amount":5800,
            "message":null,
            "gateway_response":"Approved",
            "paid_at":"2020-11-24T13:45:57.000Z",
            "created_at":"2020-11-24T13:45:57.000Z",
            "channel":"card",
            "currency":"NGN",
            "ip_address":null,
            "metadata":"",
            "log":null,
            "fees":53,
            "fees_split":null,
            "authorization":{},
            "customer":{
              "international_format_phone":null
            },
            "plan":{},
            "subaccount":{},
            "split":{},
            "order_id":null,
            "paidAt":"2020-11-24T13:45:57.000Z",
            "requested_amount":5800,
            "pos_transaction_data":null
          },
          "transaction_reference":null,
          "category":"chargeback",
          "customer":{
            "id":5406463,
            "first_name":"John",
            "last_name":"Doe",
            "email":"example@paystack.com",
            "customer_code":"CUS_6wbxh6689vt0n7s",
            "phone":"08000000000",
            "metadata":{},
            "risk_action":"allow",
            "international_format_phone":null
          },
          "bin":"123456",
          "last4":"1234",
          "dueAt":"2020-11-25T18:00:00.000Z",
          "resolvedAt":null,
          "evidence":null,
          "attachments":null,
          "note":null,
          "history":[
            {
              "status":"pending",
              "by":"example@paystack.com",
              "createdAt":"2020-11-24T13:46:57.000Z"
            }
          ],
          "messages":[
            {
              "sender":"example@paystack.com",
              "body":"Customer complained about debit without value",
              "createdAt":"2020-11-24T13:46:57.000Z"
            }
          ],
          "created_at":"2020-11-24T13:46:57.000Z",
          "updated_at":"2020-11-24T18:00:02.000Z"
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(11)
    context.response.status_code.should eq(200)
  end

  it "handles invoice events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "invoice.create",
        "data": {
          "domain": "test",
          "invoice_code": "INV_thy2vkmirn2urwv",
          "amount": 50000,
          "period_start": "2018-12-20T15:00:00.000Z",
          "period_end": "2018-12-19T23:59:59.000Z",
          "status": "success",
          "paid": true,
          "paid_at": "2018-12-20T15:00:06.000Z",
          "description": null,
          "authorization": {
            "authorization_code": "AUTH_9246d0h9kl",
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
            "signature": "SIG_iCw3p0rsG7LUiQwlsR3t",
            "account_name": "BoJack Horseman"
          },
          "subscription": {
            "status": "active",
            "subscription_code": "SUB_fq7dbe8tju0i1v8",
            "email_token": "3a1h7bcu8zxhm8k",
            "amount": 50000,
            "cron_expression": "0 * * * *",
            "next_payment_date": "2018-12-20T00:00:00.000Z",
            "open_invoice": null
          },
          "customer": {
            "id": 46,
            "first_name": "Asample",
            "last_name": "Personpaying",
            "email": "asam@ple.com",
            "customer_code": "CUS_00w4ath3e2ukno4",
            "phone": "",
            "metadata": null,
            "risk_action": "default"
          },
          "transaction": {
            "reference": "9cfbae6e-bbf3-5b41-8aef-d72c1a17650g",
            "status": "success",
            "amount": 50000,
            "currency": "NGN"
          },
          "created_at": "2018-12-20T15:00:02.000Z"
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(1000)
    context.response.status_code.should eq(200)
  end

  it "handles paymentrequest events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "paymentrequest.pending",
        "data": {
          "id": 1089700,
          "domain": "test",
          "amount": 10000000,
          "currency": "NGN",
          "due_date": null,
          "has_invoice": false,
          "invoice_number": null,
          "description": "Pay up",
          "pdf_url": null,
          "line_items": [],
          "tax": [],
          "request_code": "PRQ_y0paeo93jh99mho",
          "status": "pending",
          "paid": false,
          "paid_at": null,
          "metadata": null,
          "notifications": [],
          "offline_reference": "3365451089700",
          "customer": 7454223,
          "created_at": "2019-06-21T15:25:42.000Z"
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(101)
    context.response.status_code.should eq(200)
  end

  it "handles subscription events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "subscription.disable",
        "data": {
          "domain": "test",
          "status": "active",
          "subscription_code": "SUB_vsyqdmlzble3uii",
          "amount": 50000,
          "cron_expression": "0 0 28 * *",
          "next_payment_date": "2016-05-19T07:00:00.000Z",
          "open_invoice": null,
          "createdAt": "2016-03-20T00:23:24.000Z",
          "plan": {
            "name": "Monthly retainer",
            "plan_code": "PLN_gx2wn530m0i3w3m",
            "description": null,
            "amount": 50000,
            "interval": "monthly",
            "send_invoices": true,
            "send_sms": true,
            "currency": "NGN"
          },
          "authorization": {
            "authorization_code": "AUTH_96xphygz",
            "bin": "539983",
            "last4": "7357",
            "exp_month": "10",
            "exp_year": "2017",
            "card_type": "MASTERCARD DEBIT",
            "bank": "GTBANK",
            "country_code": "NG",
            "brand": "MASTERCARD",
            "account_name": "BoJack Horseman"
          },
          "customer": {
            "first_name": "BoJack",
            "last_name": "Horseman",
            "email": "bojack@horsinaround.com",
            "customer_code": "CUS_xnxdt6s1zg1f4nx",
            "phone": "",
            "metadata": {},
            "risk_action": "default"
          },
          "created_at": "2016-10-01T10:59:59.000Z"
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(10_002)
    context.response.status_code.should eq(200)
  end

  it "handles charge events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event":"charge.success",
        "data": {
          "id":302961,
          "domain":"live",
          "status":"success",
          "reference":"qTPrJoy9Bx",
          "amount":10000,
          "message":null,
          "gateway_response":"Approved by Financial Institution",
          "paid_at":"2016-09-30T21:10:19.000Z",
          "created_at":"2016-09-30T21:09:56.000Z",
          "channel":"card",
          "currency":"NGN",
          "ip_address":"41.242.49.37",
          "metadata":0,
          "log":{
            "time_spent":16,
            "attempts":1,
            "authentication":"pin",
            "errors":0,
            "success":false,
            "mobile":false,
            "input":[],
            "channel":null,
            "history":[
              {
                "type":"input",
                "message":"Filled these fields: card number",
                "time":15
              },
              {
                "type":"action",
                "message":"Attempted to pay",
                "time":15
              },
              {
                "type":"auth",
                "message":"Authentication Required: pin",
                "time":16
              }
            ]
          },
          "fees":null,
          "customer":{
            "id":68324,
            "first_name":"BoJack",
            "last_name":"Horseman",
            "email":"bojack@horseman.com",
            "customer_code":"CUS_qo38as2hpsgk2r0",
            "phone":null,
            "metadata":null,
            "risk_action":"default"
          },
          "authorization":{
            "authorization_code":"AUTH_f5rnfq9p",
            "bin":"539999",
            "last4":"8877",
            "exp_month":"08",
            "exp_year":"2020",
            "card_type":"mastercard DEBIT",
            "bank":"Guaranty Trust Bank",
            "country_code":"NG",
            "brand":"mastercard",
            "account_name": "BoJack Horseman"
          },
          "plan":{}
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(100_000)
    context.response.status_code.should eq(200)
  end

  it "handles transfer events" do
    path = "/webhooks/paystack"
    secret_key = "abcdef"

    body = <<-JSON
      {
        "event": "transfer.success",
        "data": {
          "amount": 30000,
          "currency": "NGN",
          "domain": "test",
          "failures": null,
          "id": 37272792,
          "integration": {
            "id": 463433,
            "is_live": true,
            "business_name": "Boom Boom Industries NG"
          },
          "reason": "Have fun...",
          "reference": "1jhbs3ozmen0k7y5efmw",
          "source": "balance",
          "source_details": null,
          "status": "success",
          "titan_code": null,
          "transfer_code": "TRF_wpl1dem4967avzm",
          "transferred_at": null,
          "recipient": {
            "active": true,
            "currency": "NGN",
            "description": "",
            "domain": "test",
            "email": null,
            "id": 8690817,
            "integration": 463433,
            "metadata": null,
            "name": "Jack Sparrow",
            "recipient_code": "RCP_a8wkxiychzdzfgs",
            "type": "nuban",
            "is_deleted": false,
            "details": {
              "account_number": "0000000000",
              "account_name": null,
              "bank_code": "011",
              "bank_name": "First Bank of Nigeria"
            },
            "created_at": "2020-09-03T12:11:25.000Z",
            "updated_at": "2020-09-03T12:11:25.000Z"
          },
          "session": { "provider": null, "id": null },
          "created_at": "2020-10-26T12:28:57.000Z",
          "updated_at": "2020-10-26T12:28:57.000Z"
        }
      }
      JSON

    signature = OpenSSL::HMAC.hexdigest(:sha512, secret_key, body)
    headers = HTTP::Headers{"X-Paystack-Signature" => signature}

    request = HTTP::Request.new("POST", path, headers, body)
    response = HTTP::Server::Response.new(IO::Memory.new)
    context = HTTP::Server::Context.new(request, response)

    TestWebhookHandler.new(secret_key, path).call(context).should eq(1_000_000)
    context.response.status_code.should eq(200)
  end
end
