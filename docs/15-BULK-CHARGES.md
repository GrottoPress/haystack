## Bulk Charges

A bulk charge is represented as `Haystack::BulkCharge`.

See <https://paystack.com/docs/api/#bulk-charge> for the raw JSON schema.

### Usage Examples

1. Initiate bulk charge:

   ```crystal
   paystack.bulk_charges.init([
     {authorization: "AUTH_n95vpedf", amount: 2500},
     {authorization: "AUTH_ljdt4e4j", amount: 1500}
   ]) do |response|
     return puts response.message unless response.success?

     response.data.try do |bulk_charge|
       puts bulk_charge.id
       puts bulk_charge.batch_code
       puts bulk_charge.pending_charges
       # ...
     end
   end
   ```

1. List bulk charges:

   ```crystal
   paystack.bulk_charges.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |bulk_charge|
       puts bulk_charge.status
       puts bulk_charge.total_charges
       puts bulk_charge.createdAt.try &.hour
       # ...
     end
   end
   ```

1. Fetch bulk charge:

   ```crystal
   paystack.bulk_charges.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |bulk_charge|
       puts bulk_charge.updatedAt.try &.minute
       puts bulk_charge.integration
       puts bulk_charge.pending_charges
       # ...
     end
   end
   ```

1. List charges in a bulk charge:

   ```crystal
   paystack.bulk_charges.charges(id: 123456, perPage: "20") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |charge|
       puts charge.id
       puts charge.amount
       puts charge.bulkcharge
       # ...
     end
   end
   ```

1. Pause bulk charge:

   ```crystal
   paystack.bulk_charges.pause("batch-code") do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```

1. Resume bulk charge:

   ```crystal
   paystack.bulk_charges.resume("batch-code") do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```
