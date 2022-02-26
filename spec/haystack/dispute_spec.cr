require "../spec_helper"

describe Haystack::Dispute::Evidence do
  describe ".from_any" do
    it "returns evidence unmodified" do
      id = 11
      evidence = Haystack::Dispute::Evidence.from_json(%({"id": #{id}}))
      evidence = Haystack::Dispute::Evidence.from_any(evidence)

      evidence.should be_a(Haystack::Dispute::Evidence)
      evidence.try(&.id).should eq(id)
    end

    it "returns evidence from integer" do
      id = 44
      evidence = Haystack::Dispute::Evidence.from_any(id)

      evidence.should be_a(Haystack::Dispute::Evidence)
      evidence.try(&.id).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Dispute::Evidence.from_any(nil).should be_nil
    end
  end
end

describe Haystack::Dispute::Endpoint do
  describe "#list" do
    it "lists disputes" do
      body = <<-JSON
        {
          "status": true,
          "message": "Disputes retrieved",
          "data": [
            {
              "id": 2867,
              "refund_amount": null,
              "currency": null,
              "status": "archived",
              "resolution": null,
              "domain": "test",
              "transaction": {
                "id": 5991760,
                "domain": "test",
                "status": "success",
                "reference": "asjck8gf76zd1dr",
                "amount": 39100,
                "message": null,
                "gateway_response": "Successful",
                "paid_at": "2017-11-09T00:01:56.000Z",
                "created_at": "2017-11-09T00:01:36.000Z",
                "channel": "card",
                "currency": "NGN",
                "ip_address": null,
                "metadata": "",
                "log": null,
                "fees": 587,
                "fees_split": null,
                "authorization": {},
                "customer": null,
                "plan": {},
                "subaccount": {},
                "split": {},
                "order_id": null,
                "paidAt": "2017-11-09T00:01:56.000Z",
                "createdAt": "2017-11-09T00:01:36.000Z",
                "pos_transaction_data": null
              },
              "transaction_reference": null,
              "category": null,
              "customer": {
                "id": 10207,
                "first_name": null,
                "last_name": null,
                "email": "shola@baddest.com",
                "customer_code": "CUS_unz4q52yjsd6064",
                "phone": null,
                "metadata": null,
                "risk_action": "default",
                "international_format_phone": null
              },
              "bin": null,
              "last4": null,
              "dueAt": null,
              "resolvedAt": null,
              "evidence": null,
              "attachments": "[]",
              "note": null,
              "history": [
                {
                  "status": "pending",
                  "by": "demo@test.co",
                  "createdAt": "2017-11-16T16:12:24.000Z"
                }
              ],
              "messages": [
                {
                  "sender": "demo@test.co",
                  "body": "test this",
                  "createdAt": "2017-11-16T16:12:24.000Z"
                }
              ],
              "createdAt": "2017-11-16T16:12:24.000Z",
              "updatedAt": "2019-08-16T08:05:25.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/dispute")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Dispute))
      end
    end
  end

  describe "#fetch" do
    it "fetches dispute" do
      body = <<-JSON
        {
          "status": true,
          "message": "Dispute retrieved",
          "data": {
            "id": 2867,
            "refund_amount": null,
            "currency": null,
            "status": "archived",
            "resolution": null,
            "domain": "test",
            "transaction": {
              "id": 5991760,
              "domain": "test",
              "status": "success",
              "reference": "asjck8gf76zd1dr",
              "amount": 39100,
              "message": null,
              "gateway_response": "Successful",
              "paid_at": "2017-11-09T00:01:56.000Z",
              "created_at": "2017-11-09T00:01:36.000Z",
              "channel": "card",
              "currency": "NGN",
              "ip_address": null,
              "metadata": "",
              "log": null,
              "fees": 587,
              "fees_split": null,
              "authorization": {},
              "customer": {
                "international_format_phone": null
              },
              "plan": {},
              "subaccount": {},
              "split": {},
              "order_id": null,
              "paidAt": "2017-11-09T00:01:56.000Z",
              "createdAt": "2017-11-09T00:01:36.000Z",
              "requested_amount": null
            },
            "transaction_reference": null,
            "category": null,
            "customer": {
              "id": 10207,
              "first_name": null,
              "last_name": null,
              "email": "shola@baddest.com",
              "customer_code": "CUS_unz4q52yjsd6064",
              "phone": null,
              "metadata": null,
              "risk_action": "default",
              "international_format_phone": null
            },
            "bin": null,
            "last4": null,
            "dueAt": null,
            "resolvedAt": null,
            "evidence": null,
            "attachments": "[]",
            "note": null,
            "history": [
              {
                "status": "pending",
                "by": "demo@test.co",
                "createdAt": "2017-11-16T16:12:24.000Z"
              }
            ],
            "messages": [
              {
                "sender": "demo@test.co",
                "body": "test this",
                "createdAt": "2017-11-16T16:12:24.000Z"
              }
            ],
            "createdAt": "2017-11-16T16:12:24.000Z",
            "updatedAt": "2019-08-16T08:05:25.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/dispute/123456")
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Dispute)
      end
    end
  end

  describe "#for_transaction" do
    it "lists disputes for a given transaction" do
      body = <<-JSON
        {
          "status": true,
          "message": "Dispute retrieved successfully",
          "data": [{
            "history": [
              {
                "id": 6094,
                "dispute": 2867,
                "status": "pending",
                "by": "demo@test.co",
                "createdAt": "2017-11-16T16:12:24.000Z",
                "updatedAt": "2017-11-16T16:12:24.000Z"
              }
            ],
            "messages": [
              {
                "sender": "demo@test.co",
                "body": "test this",
                "dispute": 2867,
                "id": 148,
                "is_deleted": 0,
                "createdAt": "2017-11-16T16:12:24.000Z",
                "updatedAt": "2017-11-16T16:12:24.000Z"
              }
            ],
            "currency": null,
            "last4": null,
            "bin": null,
            "transaction_reference": null,
            "merchant_transaction_reference": null,
            "refund_amount": null,
            "status": "archived",
            "domain": "test",
            "resolution": null,
            "category": null,
            "note": null,
            "attachments": "[]",
            "id": 2867,
            "integration": 100043,
            "transaction": {
              "id": 5991760,
              "domain": "test",
              "status": "success",
              "reference": "asjck8gf76zd1dr",
              "amount": 39100,
              "message": null,
              "gateway_response": "Successful",
              "paid_at": "2017-11-09T00:01:56.000Z",
              "created_at": "2017-11-09T00:01:36.000Z",
              "channel": "card",
              "currency": "NGN",
              "ip_address": null,
              "metadata": "",
              "log": null,
              "fees": 587,
              "fees_split": null,
              "authorization": {},
              "customer": {
                "international_format_phone": null
              },
              "plan": {},
              "subaccount": {},
              "split": {},
              "order_id": null,
              "paidAt": "2017-11-09T00:01:56.000Z",
              "createdAt": "2017-11-09T00:01:36.000Z",
              "requested_amount": null
            },
            "created_by": null,
            "evidence": null,
            "resolvedAt": null,
            "createdAt": "2017-11-16T16:12:24.000Z",
            "updatedAt": "2019-08-16T08:05:25.000Z",
            "dueAt": null
          }]
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/dispute/transaction/123456")
        .with(query: {"perPage" => "20"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.for_transaction(123456, perPage: "20") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Dispute))
      end
    end
  end

  describe "#update" do
    it "updates dispute" do
      body = <<-JSON
        {
          "status": true,
          "message": "Dispute updated successfully",
          "data": {
            "currency": "NGN",
            "last4": null,
            "bin": null,
            "transaction_reference": null,
            "merchant_transaction_reference": null,
            "refund_amount": 1002,
            "status": "resolved",
            "domain": "test",
            "resolution": "merchant-accepted",
            "source": "bank",
            "category": "general",
            "note": null,
            "attachments": "attachement",
            "id": 624,
            "transaction": {
              "id": 5991760,
              "domain": "test",
              "status": "success",
              "reference": "asjck8gf76zd1dr",
              "amount": 39100,
              "message": null,
              "gateway_response": "Successful",
              "paid_at": "2017-11-09T00:01:56.000Z",
              "created_at": "2017-11-09T00:01:36.000Z",
              "channel": "card",
              "currency": "NGN",
              "ip_address": null,
              "metadata": "",
              "log": null,
              "fees": 587,
              "fees_split": null,
              "authorization": {},
              "customer": {
                "international_format_phone": null
              },
              "plan": {},
              "subaccount": {},
              "split": {},
              "order_id": null,
              "paidAt": "2017-11-09T00:01:56.000Z",
              "createdAt": "2017-11-09T00:01:36.000Z",
              "requested_amount": null
            },
            "category": null,
            "customer": {
              "id": 10207,
              "first_name": null,
              "last_name": null,
              "email": "shola@baddest.com",
              "customer_code": "CUS_unz4q52yjsd6064",
              "phone": null,
              "metadata": null,
              "risk_action": "default",
              "international_format_phone": null
            },
            "organization": 1,
            "evidence": null,
            "resolvedAt": "2019-08-28T14:14:41.000Z",
            "createdAt": "2019-08-28T14:14:41.000Z",
            "updatedAt": "2019-08-28T14:29:07.000Z",
            "dueAt": null
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/dispute/123456")
        .with(body: %({"refund_amount":1002}))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.update(123456, refund_amount: 1002) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Dispute)
      end
    end
  end

  describe "#add_evidence" do
    it "adds evidence" do
      body = <<-JSON
        {
          "status": true,
          "message": "Evidence created",
          "data": {
            "customer_email": "cus@gmail.com",
            "customer_name": "Mensah King",
            "customer_phone": "0802345167",
            "service_details": "claim for buying product",
            "delivery_address": "3a ladoke street ogbomoso",
            "dispute": 624,
            "id": 21,
            "createdAt": "2019-08-28T15:36:13.783Z",
            "updatedAt": "2019-08-28T15:39:39.153Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/dispute/123456/evidence")
        .with(body: %({\
          "customer_email":"cus@gmail.com",\
          "customer_name":"Mensah King",\
          "customer_phone":"0802345167",\
          "service_details":"claim for buying product",\
          "delivery_address":"3a ladoke street ogbomoso"\
        }))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.add_evidence(
        123456,
        customer_email: "cus@gmail.com",
        customer_name: "Mensah King",
        customer_phone: "0802345167",
        service_details: "claim for buying product",
        delivery_address: "3a ladoke street ogbomoso"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Dispute::Evidence)
      end
    end
  end

  describe "#upload_url" do
    it "returns upload URL" do
      body = <<-JSON
        {
          "status": true,
          "message": "Upload url generated",
          "data": {
            "signedUrl": "https://s3.eu-west-1.amazonaws.com/xxx",
            "fileName": "qesp8a4df1xejihd9x5q"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/dispute/123456/upload_url")
        .with(query: {"upload_filename" => "filename.ext"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.upload_url(
        123456,
        upload_filename: "filename.ext"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Dispute::UploadUrl)
      end
    end
  end

  describe "#resolve" do
    it "resolves dispute" do
      body = <<-JSON
        {
          "status": true,
          "message": "Dispute successfully resolved",
          "data": {
            "currency": "NGN",
            "last4": null,
            "bin": null,
            "transaction_reference": null,
            "merchant_transaction_reference": null,
            "refund_amount": 1002,
            "status": "resolved",
            "domain": "test",
            "resolution": "merchant-accepted",
            "category": "general",
            "note": null,
            "attachments": "attachment",
            "id": 624,
            "transaction": {
              "id": 5991760,
              "domain": "test",
              "status": "success",
              "reference": "asjck8gf76zd1dr",
              "amount": 39100,
              "message": null,
              "gateway_response": "Successful",
              "paid_at": "2017-11-09T00:01:56.000Z",
              "created_at": "2017-11-09T00:01:36.000Z",
              "channel": "card",
              "currency": "NGN",
              "ip_address": null,
              "metadata": "",
              "log": null,
              "fees": 587,
              "fees_split": null,
              "authorization": {},
              "customer": {
                "international_format_phone": null
              },
              "plan": {},
              "subaccount": {},
              "split": {},
              "order_id": null,
              "paidAt": "2017-11-09T00:01:56.000Z",
              "createdAt": "2017-11-09T00:01:36.000Z",
              "requested_amount": null
            },
            "created_by": 30,
            "evidence": null,
            "resolvedAt": "2019-08-28T15:23:31.000Z",
            "createdAt": "2019-08-28T14:14:41.000Z",
            "updatedAt": "2019-08-28T15:23:31.000Z",
            "dueAt": null,
            "message": {
              "dispute": 624,
              "sender": "demo@test.co",
              "body": "Merchant accepted",
              "id": 718,
              "createdAt": "2019-08-28T15:23:31.418Z",
              "updatedAt": "2019-08-28T15:23:31.418Z"
            }
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/dispute/123456/resolve")
        .with(body: %({\
          "resolution":"merchant-accepted",\
          "message":"Merchant accepted",\
          "uploaded_filename":"qesp8a4df1xejihd9x5q",\
          "refund_amount":1002\
        }))
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.resolve(
        123456,
        resolution: "merchant-accepted",
        message: "Merchant accepted",
        uploaded_filename: "qesp8a4df1xejihd9x5q",
        refund_amount: 1002
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Dispute)
      end
    end
  end

  describe "#export" do
    it "exports dispute" do
      body = <<-JSON
        {
          "status": true,
          "message": "Export successful",
          "data": {
            "path": "https://s3.eu-west-1.amazonaws.com/xxx",
            "expiresAt": "2019-08-28T14:29:07.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/dispute/export")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.disputes.export(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Export)
      end
    end
  end
end
