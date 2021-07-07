## Plans

A plan is represented as `Haystack::Plan`.

See <https://paystack.com/docs/api/#plan> for the raw JSON schema.

### Usage Examples

1. Create plan:

   ```crystal
   paystack.plans.create(
     name: "Monthly retainer",
     interval: "monthly",
     amount: "500000"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |plan|
       puts plan.id
       puts plan.active_subscriptions
       puts plan.amount
       # ...
     end
   end
   ```

1. List all plans:

   ```crystal
   paystack.plans.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |plan|
       puts plan.currency
       puts plan.description
       puts plan.hosted_page
       # ...
     end
   end
   ```

1. Fetch single plan:

   ```crystal
   paystack.plans.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |plan|
       puts plan.hosted_page_summary
       puts plan.hosted_page_url
       puts plan.interval
       # ...
     end
   end
   ```

1. Update existing plan:

   ```crystal
   paystack.plans.update(id: 123456, name: "Weekly retainer") do |response|
     return puts response.message unless response.success?

     response.data.try do |plan|
       puts plan.invoice_limit
       puts plan.is_deleted
       puts plan.is_archived
       # ...
     end
   end
   ```
