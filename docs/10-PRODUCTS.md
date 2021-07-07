## Products

A product is represented as `Haystack::Product`.

See <https://paystack.com/docs/api/#product> for the raw JSON schema.

### Usage Examples

1. Create product:

   ```crystal
   paystack.products.create(
     description: "Product Six Description",
     name: "Product Six",
     price: 500000,
     currency: "USD",
     limited: false,
     quantity: 100
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |product|
       puts product.id
       puts product.currency
       puts product.description
       # ...
     end
   end
   ```

1. List all products:

   ```crystal
   paystack.products.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |product|
       puts product.features
       puts product.file_path
       puts product.image_path
       # ...
     end
   end
   ```

1. Fetch single product:

   ```crystal
   paystack.products.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |product|
       puts product.in_stock
       puts product.is_shippable
       puts product.maximum_orderable
       # ...
     end
   end
   ```

1. Update existing product:

   ```crystal
   paystack.products.update(
     id: 123456,
     description: "Product Six Description",
     name: "Product Six",
     price: 500000,
     currency: "USD",
     limited: false,
     quantity: 100
   ) do |response|
     response.data.try do |product|
       puts product.minimum_orderable
       puts product.name
       puts product.price
       # ...
     end
   end
   ```
