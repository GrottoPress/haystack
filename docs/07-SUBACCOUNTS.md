## Subaccounts

A subaccount is represented as `Haystack::Subaccount`.

See <https://paystack.com/docs/api/#subaccount> for the raw JSON schema.

### Usage Examples

1. Create subaccount:

   ```crystal
   paystack.subaccounts.create(
     business_name: "Sunshine Studios",
     settlement_bank: "044",
     account_number: "0193274682",
     percentage_charge: 18.2
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |account|
       puts account.id
       puts account.account_number
       puts account.active
       # ...
     end
   end
   ```

1. List all subaccounts:

   ```crystal
   paystack.subaccounts.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |account|
       puts account.business_name
       puts account.description
       puts account.migrate
       # ...
     end
   end
   ```

1. Fetch single subaccount:

   ```crystal
   paystack.subaccounts.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |account|
       puts account.is_verified
       puts account.percentage_charge
       puts account.primary_contact_email
       # ...
     end
   end
   ```

1. Update existing subaccount:

   ```crystal
   paystack.subaccounts.update(
     id: 123456,
     primary_contact_email: "dafe@aba.com",
     percentage_charge: 18.9
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |account|
       puts account.primary_contact_name
       puts account.primary_contact_phone
       puts account.settlement_bank
       # ...
     end
   end
   ```
