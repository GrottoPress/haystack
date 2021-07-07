require "../spec_helper"

describe Haystack::Split::Endpoint do
  describe "#create" do
    it "creates split" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Split created",
          "data": {
            "id": 142,
            "name": "Test Doc",
            "type": "percentage",
            "currency": "NGN",
            "integration": 428626,
            "domain": "test",
            "split_code": "SPL_e7jnRLtzla",
            "active": true,
            "bearer_type": "subaccount",
            "bearer_subaccount": 40809,
            "createdAt": "2020-06-30T11:42:29.150Z",
            "updatedAt": "2020-06-30T11:42:29.150Z",
            "subaccounts": [
              {
                "subaccount": {
                  "id": 40809,
                  "subaccount_code": "ACCT_z3x6z3nbo14xsil",
                  "business_name": "Business Name",
                  "description": "Business Description",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 20,
                  "settlement_bank": "Business Bank",
                  "account_number": "1234567890"
                },
                "share": 20
              },
              {
                "subaccount": {
                  "id": 40809,
                  "subaccount_code": "ACCT_pwwualwty4nhq9d",
                  "business_name": "Business Name",
                  "description": "Business Description",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 20,
                  "settlement_bank": "Business Bank",
                  "account_number": "0123456789"
                },
                "share": 30
              }
            ],
            "total_subaccounts": 2
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/split")
        .with(body: %({\
          "name":"Percentage Split",\
          "type":"percentage",\
          "currency":"NGN",\
          "subaccounts":[\
            {"subaccount":"ACCT_z3x6z3nbo14xsil","share":20},\
            {"subaccount":"ACCT_pwwualwty4nhq9d","share":30}\
          ],\
          "bearer_type":"subaccount",\
          "bearer_subaccount":"ACCT_hdl8abxl8drhrl3"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.splits.create(
        name: "Percentage Split",
        type: "percentage",
        currency: "NGN",
        subaccounts: [
          {subaccount: "ACCT_z3x6z3nbo14xsil", share: 20},
          {subaccount: "ACCT_pwwualwty4nhq9d", share: 30}
        ],
        bearer_type: "subaccount",
        bearer_subaccount: "ACCT_hdl8abxl8drhrl3"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Split)
      end
    end
  end

  describe "#list" do
    it "lists splits" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Split retrieved",
          "data": [
            {
              "id": 143,
              "name": "Test Doc",
              "split_code": "SPL_UO2vBzEqHW",
              "integration": 428626,
              "domain": "test",
              "type": "percentage",
              "active": 1,
              "currency": "NGN",
              "bearer_type": "subaccount",
              "bearer_subaccount": 40809,
              "created_at": "2020-06-30T11:52:24.000Z",
              "updated_at": "2020-06-30T11:52:24.000Z",
              "subaccounts": [
                {
                  "subaccount": {
                    "id": 40809,
                    "subaccount_code": "ACCT_z3x6z3nbo14xsil",
                    "business_name": "Business Name",
                    "description": "Business Description",
                    "primary_contact_name": null,
                    "primary_contact_email": null,
                    "primary_contact_phone": null,
                    "metadata": null,
                    "percentage_charge": 80,
                    "settlement_bank": "Business Bank",
                    "account_number": "1234567890"
                  },
                  "share": 30
                },
                {
                  "subaccount": {
                    "id": 40811,
                    "subaccount_code": "ACCT_pwwualwty4nhq9d",
                    "business_name": "Business Name",
                    "description": "Business Description",
                    "primary_contact_name": null,
                    "primary_contact_email": null,
                    "primary_contact_phone": null,
                    "metadata": null,
                    "percentage_charge": 80,
                    "settlement_bank": "Business Bank",
                    "account_number": "0123456789"
                  },
                  "share": 20
                }
              ],
              "total_subaccounts": 2
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

      WebMock.stub(:get, "https://api.paystack.co/split")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.splits.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Split))
      end
    end
  end

  describe "#fetch" do
    it "fetches split" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Split retrieved",
          "data": {
            "id": 143,
            "name": "Test Doc",
            "split_code": "SPL_UO2vBzEqHW",
            "integration": 428626,
            "domain": "test",
            "type": "percentage",
            "active": 1,
            "currency": "NGN",
            "bearer_type": "subaccount",
            "bearer_subaccount": 40809,
            "created_at": "2020-06-30T11:52:24.000Z",
            "updated_at": "2020-06-30T11:52:24.000Z",
            "subaccounts": [
              {
                "subaccount": {
                  "id": 40809,
                  "subaccount_code": "ACCT_z3x6z3nbo14xsil",
                  "business_name": "Business Name",
                  "description": "Business Description",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 80,
                  "settlement_bank": "Business Bank",
                  "account_number": "1234567890"
                },
                "share": 30
              },
              {
                "subaccount": {
                  "id": 40811,
                  "subaccount_code": "ACCT_pwwualwty4nhq9d",
                  "business_name": "Business Name",
                  "description": "Business Description",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 80,
                  "settlement_bank": "Business Bank",
                  "account_number": "0123456789"
                },
                "share": 20
              }
            ],
            "total_subaccounts": 2
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/split/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.splits.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Split)
      end
    end
  end

  describe "#update" do
    it "updates split" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Split group updated",
          "data": {
            "id": 95,
            "name": "Updated Name",
            "type": "percentage",
            "currency": "NGN",
            "integration": 165956,
            "domain": "live",
            "split_code": "SPL_uMzcGbG5ca",
            "active": false,
            "bearer_type": "all",
            "bearer_subaccount": null,
            "createdAt": "2020-06-22T16:20:53.000Z",
            "updatedAt": "2020-06-22T17:26:59.000Z",
            "subaccounts": [
              {
                "subaccount": {
                  "id": 12700,
                  "subaccount_code": "ACCT_jsuq5uwf3n8la7b",
                  "business_name": "Ayobami GTB",
                  "description": "Ayobami GTB",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 20,
                  "settlement_bank": "Guaranty Trust Bank",
                  "account_number": "0259198351"
                },
                "share": 80
              }
            ],
            "total_subaccounts": 1
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/split/123456")
        .with(body: %({"name":"Updated Name","active":true}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.splits.update(
        123456,
        name: "Updated Name",
        active: true
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Split)
      end
    end
  end

  describe "#add_account" do
    it "adds subaccount" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subaccount added",
          "data": {
            "id": 143,
            "name": "Test Doc",
            "type": "percentage",
            "currency": "NGN",
            "integration": 428626,
            "domain": "test",
            "split_code": "SPL_UO2vBzEqHW",
            "active": true,
            "bearer_type": "subaccount",
            "bearer_subaccount": 40809,
            "createdAt": "2020-06-30T11:52:24.000Z",
            "updatedAt": "2020-06-30T11:52:24.000Z",
            "subaccounts": [
              {
                "subaccount": {
                  "id": 40809,
                  "subaccount_code": "ACCT_sv6roe394nkpu6j",
                  "business_name": "Business Name",
                  "description": "Business Description",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 20,
                  "settlement_bank": "Business Bank",
                  "account_number": "1234567890"
                },
                "share": 30
              },
              {
                "subaccount": {
                  "id": 40811,
                  "subaccount_code": "ACCT_7i76qpjh7rr6q3z",
                  "business_name": "Business Name",
                  "description": "Business Description",
                  "primary_contact_name": null,
                  "primary_contact_email": null,
                  "primary_contact_phone": null,
                  "metadata": null,
                  "percentage_charge": 20,
                  "settlement_bank": "Business Bank",
                  "account_number": "0123456789"
                },
                "share": 30
              }
            ],
            "total_subaccounts": 2
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/split/123456/subaccount/add")
        .with(body: %({"subaccount":"ACCT_hdl8abxl8drhrl3","share":40000}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.splits.update_account(
        123456,
        subaccount: "ACCT_hdl8abxl8drhrl3",
        share: 40000
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Split)
      end
    end
  end

  describe "#remove_account" do
    it "removes subaccount" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Subaccount removed"
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/split/123/subaccount/remove")
        .with(body: %({"subaccount":"ACCT_hdl8abxl8drhrl3"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.splits.remove_account(
        123,
        subaccount: "ACCT_hdl8abxl8drhrl3"
      ) do |response|
        response.success?.should be_true
      end
    end
  end
end
