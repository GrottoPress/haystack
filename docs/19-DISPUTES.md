## Disputes

A dispute is represented as `Haystack::Dispute`.

See <https://paystack.com/docs/api/#dispute> for the raw JSON schema.

### Usage Examples

1. List all disputes:

   ```crystal
   paystack.disputes.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |dispute|
       puts dispute.attachments
       puts dispute.bin
       puts dispute.category
       # ...
     end
   end
   ```

1. Fetch single dispute:

   ```crystal
   paystack.disputes.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |dispute|
       puts dispute.currency
       puts dispute.due_at.try &.day
       puts dispute.last4
       # ...
     end
   end
   ```

1. List disputes for a given transaction:

   ```crystal
   paystack.disputes.for_transaction(transaction_id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |dispute|
       puts dispute.merchant_transaction_reference
       puts dispute.message
       puts dispute.note
       # ...
     end
   end
   ```

1. Update existing dispute:

   ```crystal
   paystack.disputes.update(id: 123456, refund_amount: 1002) do |response|
     return puts response.message unless response.success?

     response.data.try do |dispute|
       puts dispute.organization
       puts dispute.refund_amount
       puts dispute.resolution
       # ...
     end
   end
   ```

1. Provide evidence for a dispute:

   ```crystal
   paystack.disputes.add_evidence(
     id: 123456,
     customer_email: "cus@gmail.com",
     customer_name: "Mensah King",
     customer_phone: "0802345167",
     service_details: "claim for buying product",
     delivery_address: "3a ladoke street ogbomoso"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |evidendce|
       puts evidendce.id
       puts evidendce.customer_email
       puts evidendce.customer_name
       # ...
     end
   end
   ```

1. Get URL to upload a dispute evidence:

   ```crystal
   paystack.disputes.upload_url(
     id: 123456,
     upload_filename: "filename.ext"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |url|
       puts url.file_name
       puts url.signed_url
       # ...
     end
   end
   ```

1. Resolve dispute:

   ```crystal
   paystack.disputes.resolve(
     id: 123456,
     resolution: "merchant-accepted",
     message: "Merchant accepted",
     uploaded_filename: "qesp8a4df1xejihd9x5q",
     refund_amount: 1002
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |dispute|
       puts dispute.resolved_at.try &.month
       puts dispute.source
       puts dispute.status
       # ...
     end
   end
   ```

1. Export disputes:

   ```crystal
   paystack.disputes.export(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try do |export|
       puts export.path
       puts export.expires_at.try &.year
       # ...
     end
   end
   ```
