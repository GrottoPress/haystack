require "../spec_helper"

describe Haystack::Country::Endpoint do
  describe "#list" do
    it "lists countries" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Countries retrieved",
          "data": [
            {
              "id": 1,
              "name": "Nigeria",
              "iso_code": "NG",
              "default_currency_code": "NGN",
              "integration_defaults": {},
              "relationships": {
                "currency": {
                  "type": "currency",
                  "data": [
                    "NGN",
                    "USD"
                  ]
                },
                "integration_feature": {
                  "type": "integration_feature",
                  "data": []
                },
                "integration_type": {
                  "type": "integration_type",
                  "data": [
                    "ITYPE_001",
                    "ITYPE_002",
                    "ITYPE_003"
                  ]
                },
                "payment_method": {
                  "type": "payment_method",
                  "data": [
                    "PAYM_001",
                    "PAYM_002",
                    "PAYM_003",
                    "PAYM_004"
                  ]
                }
              }
            },
            {
              "id": 2,
              "name": "Ghana",
              "iso_code": "GH",
              "default_currency_code": "GHS",
              "integration_defaults": {},
              "relationships": {
                "currency": {
                  "type": "currency",
                  "data": [
                    "GHS",
                    "USD"
                  ]
                },
                "integration_feature": {
                  "type": "integration_feature",
                  "data": []
                },
                "integration_type": {
                  "type": "integration_type",
                  "data": [
                    "ITYPE_004",
                    "ITYPE_005"
                  ]
                },
                "payment_method": {
                  "type": "payment_method",
                  "data": [
                    "PAYM_001"
                  ]
                }
              }
            }
          ]
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/country")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.countries.list do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Country))
      end
    end
  end
end
