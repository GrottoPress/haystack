require "../spec_helper"

describe Haystack::Invoice::Endpoint do
  describe "#create" do
    it "creates invoice" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request created",
          "data": {
            "id": 3136406,
            "domain": "test",
            "amount": 42000,
            "currency": "NGN",
            "due_date": "2020-07-08T00:00:00.000Z",
            "has_invoice": true,
            "invoice_number": 1,
            "description": "a test invoice",
            "line_items": [
              {
                "name": "item 1",
                "amount": 20000
              },
              {
                "name": "item 2",
                "amount": 20000
              }
            ],
            "tax": [
              {
                "name": "VAT",
                "amount": 2000
              }
            ],
            "request_code": "PRQ_1weqqsn2wwzgft8",
            "status": "pending",
            "paid": false,
            "metadata": null,
            "notifications": [],
            "offline_reference": "4286263136406",
            "customer": 25833615,
            "created_at": "2020-06-29T16:07:33.073Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/paymentrequest")
        .with(body: %({\
          "description":"a test invoice",\
          "line_items":[\
            {"name":"item 1","amount":20000},\
            {"name":"item 2","amount":20000}\
          ],\
          "tax":[{"name":"VAT","amount":2000}],\
          "customer":"CUS_xwaj0txjryg393b",\
          "due_date":"2020-07-08"\
        }))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.create(
        description: "a test invoice",
        line_items: [
          {"name": "item 1", "amount": 20000},
          {"name": "item 2", "amount": 20000}
        ],
        tax: [{"name": "VAT", "amount": 2000}],
        customer: "CUS_xwaj0txjryg393b",
        due_date: "2020-07-08"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Invoice)
      end
    end
  end

  describe "#list" do
    it "lists invoices" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment requests retrieved",
          "data": [
            {
              "id": 3136406,
              "domain": "test",
              "amount": 42000,
              "currency": "NGN",
              "due_date": "2020-07-08T00:00:00.000Z",
              "has_invoice": true,
              "invoice_number": 1,
              "description": "a test invoice",
              "pdf_url": null,
              "line_items": [
                {
                  "name": "item 1",
                  "amount": 20000
                },
                {
                  "name": "item 2",
                  "amount": 20000
                }
              ],
              "tax": [
                {
                  "name": "VAT",
                  "amount": 2000
                }
              ],
              "request_code": "PRQ_1weqqsn2wwzgft8",
              "status": "pending",
              "paid": false,
              "paid_at": null,
              "metadata": null,
              "notifications": [],
              "offline_reference": "4286263136406",
              "customer": {
                "id": 25833615,
                "first_name": "Damilola",
                "last_name": "Odujoko",
                "email": "damilola@example.com",
                "customer_code": "CUS_xwaj0txjryg393b",
                "phone": null,
                "metadata": {
                  "calling_code": "+234"
                },
                "risk_action": "default",
                "international_format_phone": null
              },
              "created_at": "2020-06-29T16:07:33.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/paymentrequest")
        .with(query: {"perPage" => "20"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.list(perPage: "20") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Invoice))
      end
    end
  end

  describe "#fetch" do
    it "fetches invoice" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request retrieved",
          "data": {
            "transactions": [],
            "domain": "test",
            "request_code": "PRQ_1weqqsn2wwzgft8",
            "description": "a test invoice",
            "line_items": [
              {
                "name": "item 1",
                "amount": 20000
              },
              {
                "name": "item 2",
                "amount": 20000
              }
            ],
            "tax": [
              {
                "name": "VAT",
                "amount": 2000
              }
            ],
            "amount": 42000,
            "discount": null,
            "currency": "NGN",
            "due_date": "2020-07-08T00:00:00.000Z",
            "status": "pending",
            "paid": false,
            "paid_at": null,
            "metadata": null,
            "has_invoice": true,
            "invoice_number": 1,
            "offline_reference": "4286263136406",
            "pdf_url": null,
            "notifications": [],
            "archived": false,
            "source": "user",
            "payment_method": null,
            "note": null,
            "amount_paid": null,
            "id": 3136406,
            "integration": 428626,
            "customer": {
              "transactions": [],
              "subscriptions": [],
              "authorizations": [],
              "first_name": "Damilola",
              "last_name": "Odujoko",
              "email": "damilola@example.com",
              "phone": null,
              "metadata": {
                "calling_code": "+234"
              },
              "domain": "test",
              "customer_code": "CUS_xwaj0txjryg393b",
              "risk_action": "default",
              "id": 25833615,
              "integration": 428626,
              "createdAt": "2020-06-29T16:06:53.000Z",
              "updatedAt": "2020-06-29T16:06:53.000Z"
            },
            "createdAt": "2020-06-29T16:07:33.000Z",
            "updatedAt": "2020-06-29T16:07:33.000Z",
            "pending_amount": 42000
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/paymentrequest/3136406")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.fetch(3136406) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Invoice)
      end
    end
  end

  describe "#update" do
    it "updates invoice" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request updated",
          "data": {
            "id": 3136496,
            "domain": "test",
            "amount": 45000,
            "currency": "NGN",
            "due_date": "2020-06-30T22:59:59.000Z",
            "has_invoice": true,
            "invoice_number": 2,
            "description": "Update Testing",
            "pdf_url": null,
            "line_items": [
              {
                "name": "Water",
                "amount": 15000,
                "quantity": 1
              },
              {
                "name": "Bread",
                "amount": 30000,
                "quantity": 1
              }
            ],
            "tax": [],
            "request_code": "PRQ_rtjkfk1tpmvqo40",
            "status": "pending",
            "paid": false,
            "paid_at": null,
            "metadata": null,
            "notifications": [],
            "offline_reference": "4286263136496",
            "customer": {
              "id": 25833615,
              "first_name": "Damilola",
              "last_name": "Odujoko",
              "email": "damilola.odujoko@paystack.com",
              "customer_code": "CUS_xwaj0txjryg393b",
              "phone": null,
              "metadata": {
                "calling_code": "+234"
              },
              "risk_action": "default",
              "international_format_phone": null
            },
            "created_at": "2020-06-29T16:22:35.000Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/paymentrequest/abc123")
        .with(body: %({\
          "description":"Update test invoice",\
          "due_date":"2017-05-10"\
        }))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.update(
        "abc123",
        description: "Update test invoice",
        due_date: "2017-05-10"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Invoice)
      end
    end
  end

  describe "#verify" do
    it "verifies invoice" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request retrieved",
          "data": {
            "id": 3136406,
            "domain": "test",
            "amount": 42000,
            "currency": "NGN",
            "due_date": "2020-07-08T00:00:00.000Z",
            "has_invoice": true,
            "invoice_number": 1,
            "description": "a test invoice",
            "pdf_url": null,
            "line_items": [
              {
                "name": "item 1",
                "amount": 20000
              },
              {
                "name": "item 2",
                "amount": 20000
              }
            ],
            "tax": [
              {
                "name": "VAT",
                "amount": 2000
              }
            ],
            "request_code": "PRQ_1weqqsn2wwzgft8",
            "status": "pending",
            "paid": false,
            "paid_at": null,
            "metadata": null,
            "notifications": [],
            "offline_reference": "4286263136406",
            "customer": {
              "id": 25833615,
              "first_name": "Damilola",
              "last_name": "Odujoko",
              "email": "damilola@example.com",
              "customer_code": "CUS_xwaj0txjryg393b",
              "phone": null,
              "metadata": {
                "calling_code": "+234"
              },
              "risk_action": "default",
              "international_format_phone": null
            },
            "created_at": "2020-06-29T16:07:33.000Z",
            "integration": {
              "key": "pk_test_xxxxxxxx",
              "name": "Paystack Documentation",
              "logo": "https://s3-eu-west-1.amazonaws.com/pstk-integration-logos/paystack.jpg",
              "allowed_currencies": [
                "NGN",
                "USD"
              ]
            },
            "pending_amount": 42000
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/paymentrequest/verify/abc123")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.verify("abc123") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Invoice)
      end
    end
  end

  describe "#notify" do
    it "sends notification" do
      body = <<-JSON
        {
          "status": true,
          "message": "Notification sent"
        }
        JSON

      WebMock.stub(
        :post,
        "https://api.paystack.co/paymentrequest/notify/123456"
      ).to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.notify(123456) do |response|
        response.success?.should be_true
      end
    end
  end

  describe "#totals" do
    it "retrieves invoice totals" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request totals",
          "data": {
            "pending": [
              {
                "currency": "NGN",
                "amount": 42000
              },
              {
                "currency": "USD",
                "amount": 0
              }
            ],
            "successful": [
              {
                "currency": "NGN",
                "amount": 0
              },
              {
                "currency": "USD",
                "amount": 0
              }
            ],
            "total": [
              {
                "currency": "NGN",
                "amount": 42000
              },
              {
                "currency": "USD",
                "amount": 0
              }
            ]
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/paymentrequest/totals")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.totals do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Invoice::Totals)
      end
    end
  end

  describe "#finalise" do
    it "finalises invoice" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request finalized",
          "data": {
            "id": 3136496,
            "domain": "test",
            "amount": 45000,
            "currency": "NGN",
            "due_date": "2020-06-30T22:59:59.000Z",
            "has_invoice": true,
            "invoice_number": 2,
            "description": "Testing Invoice",
            "pdf_url": null,
            "line_items": [
              {
                "name": "Water",
                "amount": 15000,
                "quantity": 1
              },
              {
                "name": "Bread",
                "amount": 30000,
                "quantity": 1
              }
            ],
            "tax": [],
            "request_code": "PRQ_rtjkfk1tpmvqo40",
            "status": "pending",
            "paid": false,
            "paid_at": null,
            "metadata": null,
            "notifications": [],
            "offline_reference": "4286263136496",
            "customer": {
              "id": 25833615,
              "first_name": "Damilola",
              "last_name": "Odujoko",
              "email": "damilola@email.com",
              "customer_code": "CUS_xwaj0txjryg393b",
              "phone": null,
              "metadata": {
                "calling_code": "+234"
              },
              "risk_action": "default",
              "international_format_phone": null
            },
            "created_at": "2020-06-29T16:22:35.000Z",
            "pending_amount": 45000
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/paymentrequest/finalize/123")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.finalise(123) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Invoice)
      end
    end
  end

  describe "#archive" do
    it "archives invoice" do
      body = <<-JSON
        {
          "status": true,
          "message": "Payment request has been archived"
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/paymentrequest/archive/123")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.invoices.archive(123) do |response|
        response.success?.should be_true
      end
    end
  end
end
