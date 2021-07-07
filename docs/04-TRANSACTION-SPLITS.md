## Transaction Splits

A transaction split is represented as `Haystack::Split`.

See <https://paystack.com/docs/api/#split> for the raw JSON schema.

### Usage Examples

1. Create a split:

   ```crystal
   paystack.splits.create(
     name: "Percentage Split",
     type: "percentage",
     currency: "NGN",
     subaccounts: [
       {subaccount: "ACCT_z3x6z3nbo14xsil", share: 20},
       {subaccount: "ACCT_pwwualwty4nhq9d", share: 30}
     ],
     bearer_type: "subaccount",
     bearer_subaccount: "ACCT_hdl8abxl8drhrl3"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |split|
       puts split.id
       puts split.active
       puts split.bearer_subaccount
       # ...
     end
   end
   ```

1. List all splits:

   ```crystal
   paystack.splits.list(name: "some-split", active: "true") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |split|
       puts split.created_at
       puts split.currency
       puts split.currency
       # ...
     end
   end
   ```

1. Fetch single split:

   ```crystal
   paystack.splits.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |split|
       puts split.bearer_type
       puts split.name
       puts split.split_code
       # ...
     end
   end
   ```

1. Update existing split:

   ```crystal
   paystack.splits.update(
     id: 123456,
     name: "Updated Name",
     active: true
   ) do |response|
     return puts response.message unless response.success?

     response.data.try &.subaccounts.try &.each do |account|
       puts account.subaccount
       puts account.share
       # ...
     end
   end
   ```

1. Add/update split subaccount:

   ```crystal
   paystack.splits.add_account( # <= Alias: `#update_account`
     id: 123456,
     subaccount: "ACCT_hdl8abxl8drhrl3",
     share: 40000
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |split|
       puts split.total_subaccounts
       puts split.type
       puts split.updated_at
       # ...
     end
   end
   ```

1. Remove subaccount from split:

   ```crystal
   paystack.splits.remove_account(
     id: 123456,
     subaccount: "ACCT_hdl8abxl8drhrl3"
   ) do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```
