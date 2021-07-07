require "../spec_helper"

describe Haystack::Page::Endpoint do
  describe "#create" do
    it "creates page" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Page created",
          "data": {
            "name": "Buttercup Brunch",
            "description": "Gather your friends for the ritual that is brunch",
            "integration": 100032,
            "domain": "test",
            "slug": "5nApBwZkvY",
            "currency": "NGN",
            "active": true,
            "id": 18,
            "createdAt": "2016-03-30T00:49:57.514Z",
            "updatedAt": "2016-03-30T00:49:57.514Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/page")
        .with(body: %({\
          "name":"Buttercup Brunch",\
          "amount":500000,\
          "description":"Gather your friends for the ritual that is brunch"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.pages.create(
        name: "Buttercup Brunch",
        amount: 500000,
        description: "Gather your friends for the ritual that is brunch"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Page)
      end
    end
  end

  describe "#list" do
    it "lists pages" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Pages retrieved",
          "data": [
            {
              "integration": 100073,
              "plan": 1716,
              "domain": "test",
              "name": "Subscribe to plan: Weekly small chops",
              "description": null,
              "amount": null,
              "currency": "NGN",
              "slug": "sR7Ohx2iVd",
              "custom_fields": null,
              "redirect_url": null,
              "active": true,
              "migrate": null,
              "id": 2223,
              "createdAt": "2016-10-01T10:59:11.000Z",
              "updatedAt": "2016-10-01T10:59:11.000Z"
            },
            {
              "integration": 100073,
              "plan": null,
              "domain": "test",
              "name": "Special",
              "description": "Special page",
              "amount": 10000,
              "currency": "NGN",
              "slug": "special-me",
              "custom_fields": [
                {
                  "display_name": "Speciality",
                  "variable_name": "speciality"
                },
                {
                  "display_name": "Age",
                  "variable_name": "age"
                }
              ],
              "redirect_url": "http://special.url",
              "active": true,
              "migrate": null,
              "id": 1807,
              "createdAt": "2016-09-09T19:18:37.000Z",
              "updatedAt": "2016-09-14T17:51:49.000Z"
            }
          ],
          "meta": {
            "total": 2,
            "skipped": 0,
            "perPage": 3,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/page")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.pages.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Page))
      end
    end
  end

  describe "#fetch" do
    it "fetches page" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Page retrieved",
          "data": {
            "integration": 100032,
            "domain": "test",
            "name": "Offering collections",
            "description": "Give unto the Lord...",
            "amount": null,
            "currency": "NGN",
            "slug": "5nApBwZkvY",
            "active": true,
            "id": 18,
            "createdAt": "2016-03-30T00:49:57.000Z",
            "updatedAt": "2016-03-30T00:49:57.000Z",
            "products": [
              {
                "product_id": 523,
                "name": "Product Four",
                "description": "Product Four Description",
                "product_code": "PROD_l9p81u9pkjqjunb",
                "page": 18,
                "price": 500000,
                "currency": "NGN",
                "quantity": 0,
                "type": "good",
                "features": null,
                "is_shippable": 0,
                "domain": "test",
                "integration": 343288,
                "active": 1,
                "in_stock": 1
              },
              {
                "product_id": 522,
                "name": "Product Five",
                "description": "Product Five Description",
                "product_code": "PROD_8ne9cxutagmtsyz",
                "page": 18,
                "price": 500000,
                "currency": "NGN",
                "quantity": 0,
                "type": "good",
                "features": null,
                "is_shippable": 0,
                "domain": "test",
                "integration": 343288,
                "active": 1,
                "in_stock": 0
              }
            ]
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/page/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.pages.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Page)
      end
    end
  end

  describe "#update" do
    it "updates page" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Page updated",
          "data": {
            "domain": "test",
            "name": "Buttercup Brunch",
            "description": "Gather your friends for the ritual that is brunch",
            "amount": null,
            "currency": "NGN",
            "slug": "5nApBwZkvY",
            "active": true,
            "id": 18,
            "integration": 100032,
            "createdAt": "2016-03-30T00:49:57.000Z",
            "updatedAt": "2016-03-30T04:44:35.000Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/page/123456")
        .with(body: %({\
          "name":"Buttercup Brunch",\
          "amount":500000,\
          "description":"Gather your friends for the ritual that is brunch"\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.pages.update(
        123456,
        name: "Buttercup Brunch",
        amount: 500000,
        description: "Gather your friends for the ritual that is brunch"
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Page)
      end
    end
  end
end
