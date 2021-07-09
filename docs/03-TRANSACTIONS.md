## Transactions

A transaction is represented as `Haystack::Transaction`.

See <https://paystack.com/docs/api/#transaction> for the raw JSON schema.

### Usage Examples

1. Initialize a transaction:

   ```crystal
   paystack.transactions.init(
     email: "customer@email.com",
     amount: "20000",
     currency: "GHS"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |data|
       puts data.access_code
       puts data.authorization_url
       puts data.reference
       # ...
     end
   end
   ```

1. Verify a transaction:

   ```crystal
   paystack.transactions.verify(reference: "abcdef") do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.status
       puts transaction.authorization.try &.card_type
       puts transaction.channel
       # ...
     end
   end
   ```

1. List all transactions:

   ```crystal
   paystack.transactions.list(perPage: "20", status: "success") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |transaction|
       puts transaction.created_at
       puts transaction.currency
       puts transaction.customer
       # ...
     end
   end
   ```

1. Fetch single transaction:

   ```crystal
   paystack.transactions.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.fees
       puts transaction.gateway_response
       puts transaction.ip_address
       # ...
     end
   end
   ```

1. Charge authorization:

   ```crystal
   paystack.transactions.charge_auth(
     email: "customer@email.com",
     amount: "20000",
     authorization_code: "AUTH_72btv547"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.id
       puts transaction.message
       puts transaction.order_id
       # ...
     end
   end
   ```

1. Check authorization:

   ```crystal
   paystack.transactions.check_auth(
     email: "customer@email.com",
     amount: "20000",
     authorization_code: "AUTH_72btv547"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |data|
       puts data.amount
       puts data.currency
       # ...
     end
   end
   ```

1. View transaction timeline:

   ```crystal
   paystack.transactions.timeline("id-or-reference") do |response|
     return puts response.message unless response.success?

     response.data.try do |log|
       puts log.attempts
       puts log.authentication
       puts log.success
       # ...
     end
   end
   ```

1. View transaction totals:

   ```crystal
   paystack.transactions.totals(perPage: "20") do |response|
     return puts response.message unless response.success?

     response.data.try do |totals|
       puts totals.total_transactions
       puts totals.total_volume
       puts totals.pending_transfers
       # ...
     end
   end
   ```

1. Export transactions:

   ```crystal
   paystack.transactions.export(settled: "true") do |response|
     return puts response.message unless response.success?

     response.data.try do |export|
       puts export.path
       # ...
     end
   end
   ```

1. Retrieve part of a payment from a customer:

   ```crystal
   paystack.transactions.debit(
     authorization_code: "AUTH_72btv547",
     currency: "NGN",
     amount: "20000",
     email: "customer@email.com"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.paid_at.try &.minute
       puts transaction.pos_transaction_data
       puts transaction.requested_amount
       # ...
     end
   end
   ```
