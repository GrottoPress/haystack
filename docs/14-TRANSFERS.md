## Transfers

A transfer is represented as `Haystack::Transfer`.

See <https://paystack.com/docs/api/#transfer> for the raw JSON schema.

### Usage Examples

1. Initiate transfer:

   ```crystal
   paystack.transfers.initiate(
     source: "balance",
     reason: "Calm down",
     amount: 3794800,
     recipient: "RCP_gx2wn530m0i3w3m"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transfer|
       puts transfer.id
       puts transfer.amount
       puts transfer.currency
       # ...
     end
   end
   ```

1. Initiate bulk transfer:

   ```crystal
   paystack.transfers.initiate(
     currency: "NGN",
     source: "balance",
     transfers: [
       {
         amount: 50000,
         recipient: "RCP_db342dvqvz9qcrn",
         reference: "ref_943899312"
       },
       {
         amount: 50000,
         recipient: "RCP_db342dvqvz9qcrn",
         reference: "ref_943889313"
       }
     ]
   ) do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |transfer|
       puts transfer.amount
       puts transfer.recipient
       puts transfer.reference
       # ...
     end
   end
   ```

1. Finalize transfer:

   ```crystal
   paystack.transfers.finalise(
     transfer_code: "TRF_vsyqdmlzble3uii",
     otp: "928783"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |transfer|
       puts transfer.reference
       puts transfer.source
       puts transfer.source_details
       # ...
     end
   end
   ```

1. List all transfers:

   ```crystal
   paystack.transfers.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |transfer|
       puts transfer.domain
       puts transfer.failures
       puts transfer.reason
       # ...
     end
   end
   ```

1. Fetch single transfer:

   ```crystal
   paystack.transfers.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |transfer|
       puts transfer.status
       puts transfer.titan_code
       puts transfer.transfer_code
       # ...
     end
   end
   ```

1. Verify transfer:

   ```crystal
   paystack.transfers.verify("transfer-reference") do |response|
     return puts response.message unless response.success?

     response.data.try do |transfer|
       puts transfer.transferred_at
       puts transfer.created_at.try &.year
       puts transfer.updated_at.try &.day_of_year
       # ...
     end
   end
   ```
