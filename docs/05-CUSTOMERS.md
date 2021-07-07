## Customers

A customer is represented as `Haystack::Customer`.

See <https://paystack.com/docs/api/#customer> for the raw JSON schema.

### Usage Examples

1. Create a customer:

   ```crystal
   paystack.customers.create(email: "customer@email.com") do |response|
     return puts response.message unless response.success?

     response.data.try do |customer|
       puts customer.id
       puts customer.first_name
       puts customer.last_name
       # ...
     end
   end
   ```

1. List all customers:

   ```crystal
   paystack.customers.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |customer|
       puts customer.createdAt
       puts customer.customer_code
       puts customer.dedicated_account.try &.account_name
       # ...
     end
   end
   ```

1. Fetch single customer:

   ```crystal
   paystack.customers.fetch("email-or-code") do |response|
     return puts response.message unless response.success?

     response.data.try do |customer|
       puts customer.email
       puts customer.identified
       puts customer.international_format_phone
       # ...
     end
   end
   ```

1. Update existing customer:

   ```crystal
   paystack.customers.update(code: "a1b2c3", first_name: "Jack") do |response|
     return puts response.message unless response.success?

     response.data.try &.authorizations.try &.each do |authorization|
       puts authorization.account_name
       puts authorization.authorization_code
       puts authorization.bank
       # ...
     end
   end
   ```

1. Verify customer:

   ```crystal
   paystack.customers.verify(
     code: "abc123",
     country: "NG",
     type: "bvn",
     value: "200123456677",
     first_name: "Asta",
     last_name: "Lavista"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |identification|
       puts identification.country
       puts identification.type
       puts identification.value
       # ...
     end
   end
   ```

1. Set risk action for customer:

   ```crystal
   paystack.customers.set_risk_action(
     customer: "CUS_xr58yrr2ujlft9k",
     risk_action: "allow"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try &.identifications.try &.each do |identification|
       puts identification.country
       puts identification.type
       puts identification.value
       # ...
     end
   end
   ```

1. Deactivate authorization:

   ```crystal
   paystack.customers.deactivate_auth(
     authorization_code: "AUTH_72btv547"
   ) do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```
