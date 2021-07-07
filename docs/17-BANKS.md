## Banks

A bank is represented as `Haystack::Bank`.

See <https://paystack.com/docs/api/#miscellaneous-bank> for the raw JSON schema.

### Usage Examples

1. List all banks:

   ```crystal
   paystack.banks.list(perPage: "20", country: "ghana") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |bank|
       puts bank.active
       puts bank.code
       puts bank.currency
       # ...
     end
   end
   ```

1. List all dedicated NUBAN providers:

   ```crystal
   paystack.banks.list(pay_with_bank_transfer: "true") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |bank|
       puts bank.gateway
       puts bank.is_deleted
       puts bank.longcode
       # ...
     end
   end
   ```

1. Verify bank account:

   ```crystal
   paystack.banks.verify_account(
     account_number: "0022728151",
     bank_code: "063"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |verification|
       puts verification.account_name
       puts verification.account_number
       puts verification.bank_id
       # ...
     end
   end
   ```
