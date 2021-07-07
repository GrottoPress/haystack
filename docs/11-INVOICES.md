## Invoices

A invoice is represented as `Haystack::Invoice`.

See <https://paystack.com/docs/api/#invoice> for the raw JSON schema.

### Usage Examples

1. Create invoice:

   ```crystal
   paystack.invoices.create(
     description: "a test invoice",
     line_items: [
       {"name": "item 1", "amount": 20000},
       {"name": "item 2", "amount": 20000}
     ],
     tax: [{"name": "VAT", "amount": 2000}],
     customer: "CUS_xwaj0txjryg393b",
     due_date: "2020-07-08"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |invoice|
       puts invoice.id
       puts invoice.amount
       puts invoice.amount_paid
       # ...
     end
   end
   ```

1. List all invoices:

   ```crystal
   paystack.invoices.list(perPage: "20", page: "2") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |invoice|
       puts invoice.archived
       puts invoice.currency
       puts invoice.description
       # ...
     end
   end
   ```

1. Fetch single invoice:

   ```crystal
   paystack.invoices.fetch(id: 123456) do |response|
     return puts response.message unless response.success?

     response.data.try do |invoice|
       puts invoice.discount.try &.amount
       puts invoice.due_date.try &.day
       puts invoice.invoice_number
       # ...
     end
   end
   ```

1. Update existing invoice:

   ```crystal
   paystack.invoices.update(
     id: 123456,
     description: "Update test invoice",
     due_date: "2017-05-10"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try &.line_items.try &.each do |line_item|
       puts line_item.name
       puts line_item.amount
       # ...
     end
   end
   ```

1. Verify invoice:

   ```crystal
   paystack.invoices.verify("invoice-code") do |response|
     return puts response.message unless response.success?

     response.data.try do |invoice|
       puts invoice.note
       puts invoice.offline_reference
       puts invoice.pending_amount
       # ...
     end
   end
   ```

1. Send invoice notification:

   ```crystal
   paystack.invoices.notify("invoice-code") do |response|
     return puts response.message unless response.success?

     response.data.try do |notification|
       puts notification.sent_at
       puts notification.channel
       # ...
     end
   end
   ```

1. Get invoice totals:

   ```crystal
   paystack.invoices.totals do |response|
     return puts response.message unless response.success?

     response.data.try &.total.each do |amount|
       puts amount.amount
       puts amount.currency
       # ...
     end
   end
   ```

1. Finalize invoice:

   ```crystal
   paystack.invoices.finalise("invoice-code") do |response|
     return puts response.message unless response.success?

     response.data.try do |invoice|
       puts invoice.paid
       puts invoice.paid_at
       puts invoice.payment_method
       # ...
     end
   end
   ```

1. Archive invoice:

   ```crystal
   paystack.invoices.archive("invoice-code") do |response|
     if response.success?
       # ...
     else
       # ...
     end
   end
   ```
