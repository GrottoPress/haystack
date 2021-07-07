require "../spec_helper"

describe Haystack::Recipient::Endpoint do
  describe "#create" do
    it "creates transfer recipient" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Recipient created",
          "data": {
            "type": "nuban",
            "name": "Zombie",
            "description": "Zombier",
            "metadata": {
              "job": "Flesh Eater"
            },
            "domain": "test",
            "details": {
              "account_number": "0100000010",
              "account_name": null,
              "bank_code": "044",
              "bank_name": "Access Bank"
            },
            "currency": "NGN",
            "recipient_code": "RCP_1i2k27vk4suemug",
            "active": true,
            "id": 27,
            "createdAt": "2017-02-02T19:35:33.686Z",
            "updatedAt": "2017-02-02T19:35:33.686Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transferrecipient")
        .with(body: %({\
          "type":"nuban",\
          "name":"Zombie",\
          "description":"Zombier",\
          "account_number":"01000000010",\
          "bank_code":"044",\
          "currency":"NGN"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.recipients.create(
        type: "nuban",
        name: "Zombie",
        description: "Zombier",
        account_number: "01000000010",
        bank_code: "044",
        currency: "NGN"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Recipient)
      end
    end

    it "creates many transfer recipients" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Recipients added successfully",
          "data": {
            "success": [
              {
                "domain": "test",
                "name": "Habenero Mundane",
                "type": "nuban",
                "description": "",
                "integration": 463433,
                "currency": "NGN",
                "metadata": null,
                "details": {
                  "account_number": "0123456789",
                  "account_name": null,
                  "bank_code": "033",
                  "bank_name": "United Bank For Africa"
                },
                "recipient_code": "RCP_wh5k8r4vzuh5c94",
                "active": true,
                "id": 10152540,
                "isDeleted": false,
                "createdAt": "2020-11-09T10:12:48.213Z",
                "updatedAt": "2020-11-09T10:12:48.213Z"
              },
              {
                "domain": "test",
                "name": "Soft Merry",
                "type": "nuban",
                "description": "",
                "integration": 463433,
                "currency": "NGN",
                "metadata": null,
                "details": {
                  "account_number": "98765432310",
                  "account_name": null,
                  "bank_code": "50211",
                  "bank_name": "Kuda Bank"
                },
                "recipient_code": "RCP_yu1kkyktoljnczg",
                "active": true,
                "id": 10152541,
                "isDeleted": false,
                "createdAt": "2020-11-09T10:12:48.213Z",
                "updatedAt": "2020-11-09T10:12:48.213Z"
              }
            ],
            "errors": []
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/transferrecipient/bulk")
        .with(body: %({\
          "batch":[\
            {\
              "type":"nuban",\
              "name":"Habenero Mundane",\
              "account_number":"0123456789",\
              "bank_code":"033",\
              "currency":"NGN"\
            },\
            {\
              "type":"nuban",\
              "name":"Soft Merry",\
              "account_number":"98765432310",\
              "bank_code":"50211",\
              "currency":"NGN"\
            }\
          ]\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.recipients.create([
        {
          type: "nuban",
          name: "Habenero Mundane",
          account_number: "0123456789",
          bank_code: "033",
          currency: "NGN"
        },
        {
          type: "nuban",
          name: "Soft Merry",
          account_number: "98765432310",
          bank_code: "50211",
          currency: "NGN"
        }
      ]) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Recipient::Bulk)
      end
    end
  end

  describe "#list" do
    it "lists transfer recipients" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Recipients retrieved",
          "data": [
            {
              "domain": "test",
              "type": "nuban",
              "currency": "NGN",
              "name": "Flesh",
              "details": {
                "account_number": "01000000000",
                "account_name": null,
                "bank_code": "044",
                "bank_name": "Access Bank"
              },
              "metadata": {
                "job": "Eater"
              },
              "recipient_code": "RCP_2x5j67tnnw1t98k",
              "active": true,
              "id": 28,
              "createdAt": "2017-02-02T19:39:04.000Z",
              "updatedAt": "2017-02-02T19:39:04.000Z"
            },
            {
              "integration": 100073,
              "domain": "test",
              "type": "nuban",
              "currency": "NGN",
              "name": "Flesh",
              "details": {
                "account_number": "0100000010",
                "account_name": null,
                "bank_code": "044",
                "bank_name": "Access Bank"
              },
              "metadata": {},
              "recipient_code": "RCP_1i2k27vk4suemug",
              "active": true,
              "id": 27,
              "createdAt": "2017-02-02T19:35:33.000Z",
              "updatedAt": "2017-02-02T19:35:33.000Z"
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

      WebMock.stub(:get, "https://api.paystack.co/transferrecipient")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.recipients.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Recipient))
      end
    end
  end

  describe "#fetch" do
    it "fetches transfer recipient" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Recipient retrieved",
          "data": {
            "domain": "test",
            "type": "nuban",
            "currency": "NGN",
            "name": "Flesh",
            "details": {
              "account_number": "01000000000",
              "account_name": null,
              "bank_code": "044",
              "bank_name": "Access Bank"
            },
            "metadata": {
              "job": "Eater"
            },
            "recipient_code": "RCP_2x5j67tnnw1t98k",
            "active": true,
            "id": 28,
            "createdAt": "2017-02-02T19:39:04.000Z",
            "updatedAt": "2017-02-02T19:39:04.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/transferrecipient/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.recipients.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Recipient)
      end
    end
  end

  describe "#update" do
    it "updates transfer recipient" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Recipient updated",
          "data": {
            "type": "nuban",
            "name": "Rick Sanchez",
            "metadata": {
              "job": "Flesh Eater",
              "retired": true
            },
            "domain": "test",
            "details": {
              "account_number": "01000000010",
              "account_name": null,
              "bank_code": "044",
              "bank_name": "Access Bank"
            },
            "currency": "NGN",
            "recipient_code": "RCP_1i2k27vk4suemug",
            "active": true,
            "id": 27,
            "createdAt": "2017-02-02T19:35:33.686Z",
            "updatedAt": "2017-02-02T19:35:33.686Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/transferrecipient/123456")
        .with(body: %({"name":"Rick Sanchez"}))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.recipients.update(123456, name: "Rick Sanchez") do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Recipient)
      end
    end
  end

  describe "#delete" do
    it "deletes transfer recipient" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Transfer recipient set as inactive"
        }
        JSON

      WebMock.stub(:delete, "https://api.paystack.co/transferrecipient/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.recipients.delete(123456) do |response|
        response.success?.should be_true
      end
    end
  end
end
