## Dedicated NUBAN

See <https://paystack.com/docs/api/#dedicated-nuban>

### Usage Examples

1. Create a dedicated account:

   ```crystal
   paystack.nubans.create(
     customer: 481193,
     preferred_bank: "wema-bank"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |account|
       puts account.account_name
       puts account.account_number
       puts account.active
       # ...
     end
   end
   ```

1. List all dedicated accounts:

   ```crystal
   paystack.nubans.list(active: "true", currency: "USD") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |account|
       puts account.assigned
       puts account.assignment.try &.account_type
       puts account.bank.try &.code
       # ...
     end
   end
   ```

1. Fetch single dedicated account:

   ```crystal
   paystack.nubans.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |customer|
       puts customer.dedicated_account.try &.id
       puts customer.phone
       puts customer.customer_code
       # ...
     end
   end
   ```

1. Deactivate existing dedicated account:

   ```crystal
   paystack.nubans.deactivate(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |account|
       puts account.metadata.try &.json_unmapped["some_key"]
       puts account.metadata.try &.recurring
       puts account.currency
       # ...
     end
   end
   ```

1. Split dedicated account transactions:

   ```crystal
   paystack.nubans.split(
     customer: 481193,
     preferred_bank: "wema-bank",
     split_code: "SPL_e7jnRLtzla"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try &.split_config.try do |split_config|
       puts split_config.bearer_subaccount
       puts split_config.bearer_type
       puts split_config.total_subaccounts
       # ...
     end
   end
   ```

1. Remove split from dedicated account:

   ```crystal
   paystack.nubans.unsplit(account_number: "0033322211") do |response|
     return puts response.message unless response.success?

     response.data.try &.split_config.try do |split_config|
       puts split_config.id
       puts split_config.split_code
       puts split_config.currency
       # ...
     end
   end
   ```

1. List bank providers:

   ```crystal
   paystack.nubans.providers do |response|
     response.data.try do |provider|
       puts provider.provider_slug
       puts provider.bank_id
       puts provider.bank_name
       # ...
     end
   end
   ```
