require "../spec_helper"

describe Haystack::Settlement do
  describe ".from_any" do
    it "returns settlement unmodified" do
      id = 11
      settlement = Haystack::Settlement.from_json(%({"id": #{id}}))
      settlement = Haystack::Settlement.from_any(settlement)

      settlement.should be_a(Haystack::Settlement)
      settlement.try(&.id).should eq(id)
    end

    it "returns settlement from integer" do
      id = 44
      settlement = Haystack::Settlement.from_any(id)

      settlement.should be_a(Haystack::Settlement)
      settlement.try(&.id).should eq(id)
    end

    it "returns nil from nil" do
      Haystack::Settlement.from_any(nil).should be_nil
    end
  end
end

describe Haystack::Settlement::Endpoint do
  describe "#list" do
    it "lists settlements" do
      body = <<-JSON
        {
          "status": true,
          "message": "Settlements retrieved",
          "data": [
            {
              "integration": 199999,
              "settled_by": null,
              "settlement_date": "2016-11-04T00:00:00.000Z",
              "domain": "live",
              "total_amount": 28350,
              "status": "pending",
              "id": 8597,
              "createdAt": "2016-11-04T00:00:00.000Z",
              "updatedAt": null
            },
            {
              "integration": 199999,
              "subaccount": {
                "domain": "live",
                "subaccount_code": "ACCT_83uhio98ueej",
                "business_name": "Someone, Somewhere",
                "description": null,
                "primary_contact_name": null,
                "primary_contact_email": null,
                "primary_contact_phone": null,
                "metadata": null,
                "percentage_charge": 1,
                "is_verified": false,
                "settlement_bank": "Guaranty Trust Bank",
                "account_number": "0909090909",
                "settlement_schedule": "WEEKLY",
                "active": true,
                "migrate": null,
                "id": 23,
                "integration": 199999,
                "createdAt": "2016-10-03T13:14:36.000Z",
                "updatedAt": "2016-11-03T14:21:52.000Z"
              },
              "settled_by": null,
              "settlement_date": "2016-11-04T00:00:00.000Z",
              "domain": "live",
              "total_amount": 80000,
              "status": "pending",
              "id": 8598,
              "createdAt": "2016-11-04T00:00:00.000Z",
              "updatedAt": null
            }
          ],
          "meta": {
            "total": 4,
            "skipped": 0,
            "perPage": 50,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/settlement")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.settlements.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Settlement))
      end
    end
  end

  describe "#transactions" do
    it "lists settlement transactions" do
      body = <<-JSON
        {
          "status": true,
          "message": "Transactions retrieved",
          "data": [
            {
              "id": 480955498,
              "reference": "T807207882369486",
              "amount": 10000000,
              "created_at": "2020-02-07T06:36:51.000Z",
              "paidAt": "2020-02-07T06:39:34.000Z",
              "currency": "NGN",
              "channel": "card",
              "domain": "live",
              "message": null,
              "gateway_response": "Approved",
              "fees": 0
            },
            {
              "id": 480806874,
              "reference": "T590843487090242",
              "amount": 100000,
              "created_at": "2020-02-07T05:22:10.000Z",
              "paidAt": "2020-02-07T05:23:29.000Z",
              "currency": "NGN",
              "channel": "card",
              "domain": "live",
              "message": null,
              "gateway_response": "Approved",
              "fees": 0
            }
          ],
          "meta": {
            "total": 2,
            "total_volume": 10100000,
            "skipped": 0,
            "perPage": 100,
            "page": 1,
            "pageCount": 0
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/settlement/123/transactions")
        .with(query: {"perPage" => "20"})
        .to_return(body: body)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.settlements.transactions(123, perPage: "20") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Transaction))
      end
    end
  end
end
