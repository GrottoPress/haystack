## Refunds

A refund is represented as `Haystack::Refund`.

See <https://paystack.com/docs/api/#refund> for the raw JSON schema.

### Usage Examples

1. Create refund:

   ```crystal
   paystack.refunds.create(transaction: 1641) do |response|
     return puts response.message unless response.success?

     response.data.try do |refund|
       puts refund.id
       puts refund.amount
       puts refund.channel
       # ...
     end
   end
   ```

1. List all refunds:

   ```crystal
   paystack.refunds.list(perPage: "20", currency: "NGN") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |refund|
       puts refund.customer_note
       puts refund.deducted_amount
       puts refund.dispute
       # ...
     end
   end
   ```

1. Fetch single refund:

   ```crystal
   paystack.refunds.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |refund|
       puts refund.expected_at.try &.hour
       puts refund.fully_deducted
       puts refund.merchant_note
       # ...
     end
   end
   ```
