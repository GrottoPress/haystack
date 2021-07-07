## Transfer Recipients

A recipient is represented as `Haystack::Recipient`.

See <https://paystack.com/docs/api/#transfer-recipient> for the raw JSON schema.

### Usage Examples

1. Create recipient:

   ```crystal
   paystack.recipients.create(
     type: "nuban",
     name: "Zombie",
     description: "Zombier",
     account_number: "01000000010",
     bank_code: "044",
     currency: "NGN"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |recipient|
       puts recipient.id
       puts recipient.active
       puts recipient.currency
       # ...
     end
   end
   ```

1. Bulk-create recipients:

   ```crystal
   paystack.recipients.create([
     {
       type: "nuban",
       name: "Habenero Mundane",
       account_number: "0123456789",
       bank_code: "033",
       currency: "NGN"
     },
     {
       type: "nuban",
       name: "Soft Merry",
       account_number: "98765432310",
       bank_code: "50211",
       currency: "NGN"
     }
   ]) do |response|
     return puts response.message unless response.success?

     response.data.try &.success.each do |recipient|
       puts recipient.description
       puts recipient.email
       puts recipient.is_deleted
       # ...
     end
   end
   ```

1. List all recipients:

   ```crystal
   paystack.recipients.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |recipient|
       puts recipient.name
       puts recipient.recipient_code
       puts recipient.type
       # ...
     end
   end
   ```

1. Fetch single recipient:

   ```crystal
   paystack.recipients.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |recipient|
       puts recipient.createdAt.try &.day
       puts recipient.updatedAt.try &.month
       puts recipient.isDeleted
       # ...
     end
   end
   ```

1. Update existing recipient:

   ```crystal
   paystack.recipients.update(id: 123456, name: "Rick Sanchez") do |response|
     return puts response.message unless response.success?

     response.data.try do |recipient|
       puts recipient.description
       puts recipient.email
       puts recipient.is_deleted
       # ...
     end
   end
   ```

1. Delete existing recipient:

   ```crystal
   paystack.transfers.delete(id: 123456) do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```
