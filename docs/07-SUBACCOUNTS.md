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

     response.data.try do |subaccount|
       puts subaccount.id
       puts subaccount.account_number
       puts subaccount.active
       # ...
     end
   end
   ```

1. List all subaccounts:

   ```crystal
   paystack.subaccounts.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |subaccount|
       puts subaccount.business_name
       puts subaccount.description
       puts subaccount.migrate
       # ...
     end
   end
   ```

1. Fetch single subaccount:

   ```crystal
   paystack.subaccounts.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |subaccount|
       puts subaccount.is_verified
       puts subaccount.percentage_charge
       puts subaccount.primary_contact_email
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

     response.data.try do |subaccount|
       puts subaccount.primary_contact_name
       puts subaccount.primary_contact_phone
       puts subaccount.settlement_bank
       # ...
     end
   end
   ```
