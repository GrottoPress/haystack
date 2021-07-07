require "../spec_helper"

describe Haystack::Product::Endpoint do
  describe "#create" do
    it "creates product" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Product successfully created",
          "data": {
            "name": "Product One",
            "description": "Product One Description",
            "currency": "NGN",
            "price": 500000,
            "unlimited": true,
            "domain": "test",
            "integration": 343288,
            "product_code": "PROD_f58aly7bvn32uiz",
            "quantity": 0,
            "type": "good",
            "is_shippable": false,
            "active": true,
            "in_stock": true,
            "id": 524,
            "createdAt": "2019-06-29T14:10:29.742Z",
            "updatedAt": "2019-06-29T14:10:29.742Z"
          }
        }
        JSON

      WebMock.stub(:post, "https://api.paystack.co/product")
        .with(body: %({\
          "description":"Product Six Description",\
          "name":"Product Six",\
          "price":500000,\
          "currency":"USD",\
          "limited":false,\
          "quantity":100\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.products.create(
        description: "Product Six Description",
        name: "Product Six",
        price: 500000,
        currency: "USD",
        limited: false,
        quantity: 100
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Product)
      end
    end
  end

  describe "#list" do
    it "lists products" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Products retrieved",
          "data": [
            {
              "integration": 343288,
              "name": "Product Four",
              "description": "Product Four Description",
              "product_code": "PROD_l9p81u9pkjqjunb",
              "price": 500000,
              "currency": "NGN",
              "quantity": 0,
              "quantity_sold": null,
              "type": "good",
              "image_path": "",
              "file_path": "",
              "is_shippable": false,
              "unlimited": true,
              "domain": "test",
              "active": true,
              "features": null,
              "in_stock": true,
              "metadata": null,
              "id": 523,
              "createdAt": "2019-06-29T14:06:01.000Z",
              "updatedAt": "2019-06-29T14:06:01.000Z"
            },
            {
              "integration": 343288,
              "name": "Product Five",
              "description": "Product Five Description",
              "product_code": "PROD_8ne9cxutagmtsyz",
              "price": 500000,
              "currency": "NGN",
              "quantity": 0,
              "quantity_sold": null,
              "type": "good",
              "image_path": "",
              "file_path": "",
              "is_shippable": false,
              "unlimited": false,
              "domain": "test",
              "active": true,
              "features": null,
              "in_stock": false,
              "metadata": null,
              "id": 522,
              "createdAt": "2019-06-29T14:04:50.000Z",
              "updatedAt": "2019-06-29T14:04:50.000Z"
            }
          ],
          "meta": {
            "total": 5,
            "skipped": 0,
            "perPage": 50,
            "page": 1,
            "pageCount": 1
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/product")
        .with(query: {"perPage" => "20", "page" => "2"})
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.products.list(perPage: "20", page: "2") do |response|
        response.success?.should be_true
        response.data.should be_a(Array(Haystack::Product))
      end
    end
  end

  describe "#fetch" do
    it "fetches product" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Product retrieved",
          "data": {
              "integration": 343288,
              "name": "Prod 1",
              "description": "Prod 1",
              "product_code": "PROD_ohc0xq1ajpt2271",
              "price": 20000,
              "currency": "NGN",
              "quantity": 5,
              "quantity_sold": null,
              "type": "good",
              "image_path": "",
              "file_path": "",
              "is_shippable": false,
              "unlimited": false,
              "domain": "test",
              "active": true,
              "features": null,
              "in_stock": true,
              "metadata": null,
              "id": 526,
              "createdAt": "2019-06-29T14:46:52.000Z",
              "updatedAt": "2019-06-29T14:46:52.000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.paystack.co/product/123456")
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.products.fetch(123456) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Product)
      end
    end
  end

  describe "#update" do
    it "updates product" do
      response_json = IO::Memory.new <<-JSON
        {
          "status": true,
          "message": "Product successfully updated",
          "data": {
            "name": "Prod One",
            "description": "Prod 1",
            "product_code": "PROD_ohc0xq1ajpt2271",
            "price": 20000,
            "currency": "NGN",
            "quantity": 5,
            "quantity_sold": null,
            "type": "good",
            "image_path": "",
            "file_path": "",
            "is_shippable": false,
            "unlimited": false,
            "domain": "test",
            "active": true,
            "features": null,
            "in_stock": true,
            "metadata": null,
            "id": 526,
            "integration": 343288,
            "createdAt": "2019-06-29T14:46:52.000Z",
            "updatedAt": "2019-06-29T15:29:21.000Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.paystack.co/product/123456")
        .with(body: %({\
          "description":"Product Six Description",\
          "name":"Product Six",\
          "price":500000,\
          "currency":"USD",\
          "limited":false,\
          "quantity":100\
        }))
        .to_return(body_io: response_json)

      paystack = Haystack.new(secret_key: "abcdef")

      paystack.products.update(
        123456,
        description: "Product Six Description",
        name: "Product Six",
        price: 500000,
        currency: "USD",
        limited: false,
        quantity: 100
      ) do |response|
        response.success?.should be_true
        response.data.should be_a(Haystack::Product)
      end
    end
  end
end
