## Settlements

A settlement is represented as `Haystack::Settlement`.

See <https://paystack.com/docs/api/#settlement> for the raw JSON schema.

### Usage Examples

1. List all settlements:

   ```crystal
   paystack.settlements.list(perPage: "20", subaccount: "none") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |settlement|
       puts settlement.id
       puts settlement.settled_by
       puts settlement.settlement_date.try &.month
       # ...
     end
   end
   ```

1. List all transactions for a settlement:

   ```crystal
   paystack.settlements.transactions(id: 12345, perPage: "20") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |transaction|
       puts transaction.amount
       puts transaction.authorization.try &.authorization_code
       puts transaction.currency
       # ...
     end
   end
   ```
