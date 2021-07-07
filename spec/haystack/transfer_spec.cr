require "../spec_helper"

describe Haystack::Transfer::Endpoint do
  describe "#init" do
    it "initiates transfer" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transfer requires OTP to continue",
          "data": {
            "integration": 100073,
            "domain": "test",
            "amount": 3794800,
            "currency": "NGN",
            "source": "balance",
            "reason": "Calm down",
            "recipient": 28,
            "status": "otp",
            "transfer_code": "TRF_1ptvuv321ahaa7q",
            "id": 14,
            "createdAt": "2017-02-03T17:21:54.508Z",
            "updatedAt": "2017-02-03T17:21:54.508Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transfer")
        .with(body: %({\
          "source":"balance",\
          "reason":"Calm down",\
          "amount":3794800,\
          "recipient":"RCP_gx2wn530m0i3w3m"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transfers.init(
        source: "balance",
        reason: "Calm down",
        amount: 3794800,
        recipient: "RCP_gx2wn530m0i3w3m"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transfer)
      end
    end

    it "initiates many transfers" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "2 transfers queued.",
          "data": [
            {
              "recipient": "RCP_db342dvqvz9qcrn",
              "amount": 50000,
              "transfer_code": "TRF_jblmryckdrc6zq4",
              "currency": "NGN"
            },
            {
              "recipient": "RCP_db342dvqvz9qcrn",
              "amount": 50000,
              "transfer_code": "TRF_yqs7t2w2xndexy7",
              "currency": "NGN"
            }
          ]
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transfer/bulk")
        .with(body: %({\
          "currency":"NGN",\
          "source":"balance",\
          "transfers":[\
            {\
              "amount":50000,\
              "recipient":"RCP_db342dvqvz9qcrn",\
              "reference":"ref_943899312"\
            },\
            {\
              "amount":50000,\
              "recipient":"RCP_db342dvqvz9qcrn",\
              "reference":"ref_943889313"\
            }\
          ]\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transfers.init(
        currency: "NGN",
        source: "balance",
        transfers: [
          {
            amount: 50000,
            recipient: "RCP_db342dvqvz9qcrn",
            reference: "ref_943899312"
          },
          {
            amount: 50000,
            recipient: "RCP_db342dvqvz9qcrn",
            reference: "ref_943889313"
          }
        ]
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Transfer))
      end
    end
  end

  describe "#finalise" do
    it "finalizes transfer" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transfer has been queued",
          "data": {
            "domain": "test",
            "amount": 1000000,
            "currency": "NGN",
            "reference": "n7ll9pzl6b",
            "source": "balance",
            "source_details": null,
            "reason": "E go better for you",
            "status": "success",
            "failures": null,
            "transfer_code": "TRF_zuirlnr9qblgfko",
            "titan_code": null,
            "transferred_at": null,
            "id": 529410,
            "integration": 123460,
            "recipient": 225204,
            "createdAt": "2018-08-02T10:02:55.000Z",
            "updatedAt": "2018-08-02T10:12:05.000Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transfer/finalize_transfer")
        .with(body: %({"transfer_code":"TRF_vsyqdmlzble3uii","otp":"928783"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transfers.finalise(
        transfer_code: "TRF_vsyqdmlzble3uii",
        otp: "928783"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transfer)
      end
    end
  end

  describe "#list" do
    it "lists transfers" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transfers retrieved",
          "data": [
            {
              "integration": 100073,
              "recipient": {
                "domain": "test",
                "type": "nuban",
                "currency": "NGN",
                "name": "Flesh",
                "details": {
                  "account_number": "olounje",
                  "account_name": null,
                  "bank_code": "044",
                  "bank_name": "Access Bank"
                },
                "description": "Eater",
                "metadata": null,
                "recipient_code": "RCP_2x5j67tnnw1t98k",
                "active": true,
                "id": 28,
                "integration": 100073,
                "createdAt": "2017-02-02T19:39:04.000Z",
                "updatedAt": "2017-02-02T19:39:04.000Z"
              },
              "domain": "test",
              "amount": 4400,
              "currency": "NGN",
              "source": "balance",
              "source_details": null,
              "reason": "Eater",
              "status": "otp",
              "failures": null,
              "transfer_code": "TRF_1ptvuv321ahaa7q",
              "id": 14,
              "createdAt": "2017-02-03T17:21:54.000Z",
              "updatedAt": "2017-02-03T17:21:54.000Z"
            },
            {
              "integration": 100073,
              "recipient": {
                "domain": "test",
                "type": "nuban",
                "currency": "USD",
                "name": "FleshUSD",
                "details": {
                  "account_number": "1111111111",
                  "account_name": null,
                  "bank_code": "044",
                  "bank_name": "Access Bank"
                },
                "description": "EaterUSD",
                "metadata": null,
                "recipient_code": "RCP_bi84k5gguakuqmg",
                "active": true,
                "id": 22,
                "integration": 100073,
                "createdAt": "2017-01-23T16:52:48.000Z",
                "updatedAt": "2017-01-23T16:52:48.000Z"
              },
              "domain": "test",
              "amount": 3300,
              "currency": "NGN",
              "source": "balance",
              "source_details": null,
              "reason": "I love you",
              "status": "otp",
              "failures": null,
              "transfer_code": "TRF_5pr8ypzb0htx0cn",
              "id": 13,
              "createdAt": "2017-01-23T16:55:59.000Z",
              "updatedAt": "2017-01-23T16:55:59.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/transfer")
        .with(query: {"perTransfer" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transfers.list(perTransfer: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Transfer))
      end
    end
  end

  describe "#fetch" do
    it "fetches transfer" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transfer retrieved",
          "data": {
            "recipient": {
              "domain": "test",
              "type": "nuban",
              "currency": "NGN",
              "name": "Flesh",
              "details": {
                "account_number": "olounje",
                "account_name": null,
                "bank_code": "044",
                "bank_name": "Access Bank"
              },
              "metadata": null,
              "recipient_code": "RCP_2x5j67tnnw1t98k",
              "active": true,
              "id": 28,
              "integration": 100073,
              "createdAt": "2017-02-02T19:39:04.000Z",
              "updatedAt": "2017-02-02T19:39:04.000Z"
            },
            "domain": "test",
            "amount": 4400,
            "currency": "NGN",
            "source": "balance",
            "source_details": null,
            "reason": "Redemption",
            "status": "pending",
            "failures": null,
            "transfer_code": "TRF_2x5j67tnnw1t98k",
            "id": 14938,
            "createdAt": "2017-02-03T17:21:54.000Z",
            "updatedAt": "2017-02-03T17:21:54.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transfer/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transfers.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transfer)
      end
    end
  end

  describe "#verify" do
    it "verifies transfer" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transfer retrieved",
          "data": {
            "integration": 119333,
            "recipient": {
              "domain": "test",
              "type": "nuban",
              "currency": "NGN",
              "name": "Zombie",
              "details": {
                "account_number": "0100000001",
                "account_name": null,
                "bank_code": "044",
                "bank_name": "Access Bank"
              },
              "description": "Zombier",
              "metadata": "",
              "recipient_code": "RCP_c2mty1w1uvd4av4",
              "active": true,
              "email": null,
              "id": 31911,
              "integration": 119333,
              "createdAt": "2017-10-13T20:35:51.000Z",
              "updatedAt": "2017-10-13T20:35:51.000Z"
            },
            "domain": "test",
            "amount": 50000,
            "currency": "NGN",
            "reference": "ref_demo",
            "source": "balance",
            "source_details": null,
            "reason": "Test for reference",
            "status": "success",
            "failures": null,
            "transfer_code": "TRF_kjati32r73poyt5",
            "titan_code": null,
            "transferred_at": null,
            "id": 476948,
            "createdAt": "2018-07-22T10:29:33.000Z",
            "updatedAt": "2018-07-22T10:29:33.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transfer/verify/a1b2c3")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.transfers.verify("a1b2c3") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Transfer)
      end
    end
  end
end
