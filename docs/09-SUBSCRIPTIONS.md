## Subscriptions

A subscription is represented as `Haystack::Subscription`.

See <https://paystack.com/docs/api/#subscription> for the raw JSON schema.

### Usage Examples

1. Create subscription:

   ```crystal
   paystack.subscriptions.create(
     customer: "CUS_xnxdt6s1zg1f4nx",
     plan: "PLN_gx2wn530m0i3w3m"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |subscription|
       puts subscription.id
       puts subscription.authorization.try &.account_name
       puts subscription.cron_expression
       # ...
     end
   end
   ```

1. List all subscriptions:

   ```crystal
   paystack.subscriptions.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |subscription|
       puts subscription.customer.try &.email
       puts subscription.easy_cron_id
       puts subscription.email_token
       # ...
     end
   end
   ```

1. Fetch single subscription:

   ```crystal
   paystack.subscriptions.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |subscription|
       puts subscription.invoice_limit
       puts subscription.next_payment_date
       puts subscription.open_invoice
       # ...
     end
   end
   ```

1. Enable subscription:

   ```crystal
   paystack.subscriptions.enable(
     code: "SUB_vsyqdmlzble3uii",
     token: "d7gofp6yppn3qz7"
   ) do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```

1. Disable subscription:

   ```crystal
   paystack.subscriptions.disable(
     code: "SUB_vsyqdmlzble3uii",
     token: "d7gofp6yppn3qz7"
   ) do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```
