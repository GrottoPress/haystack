## Charges

See <https://paystack.com/docs/api/#charge>

### Usage Examples

1. Create charge:

   ```crystal
   paystack.charges.create(
     email: "customer@email.com",
     amount: "20000"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.transaction_date.try &.second
       puts transaction.subaccount.try &.account_number
       puts transaction.status
       # ...
     end
   end
   ```

1. Submit PIN:

   ```crystal
   paystack.charges.submit_pin(
     pin: "1234",
     reference: "5bwib5v6anhe9xa"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.split.try &.split_code
       puts transaction.source
       puts transaction.requested_amount
       # ...
     end
   end
   ```

1. Submit OTP:

   ```crystal
   paystack.charges.submit_otp(
     otp: "123456",
     reference: "5bwib5v6anhe9xa"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.pos_transaction_data
       puts transaction.paid_at.try &.sunday?
       puts transaction.order_id
       # ...
     end
   end
   ```

1. Submit phone:

   ```crystal
   paystack.charges.submit_phone(
     phone: "08012345678",
     reference: "5bwib5v6anhe9xa"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.message
       puts transaction.log.try &.start_time
       puts transaction.ip_address
       # ...
     end
   end
   ```

1. Submit birthday:

   ```crystal
   paystack.charges.submit_birthday(
     birthday: "1961-09-21",
     reference: "5bwib5v6anhe9xa"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.id
       puts transaction.gateway_response
       puts transaction.fees_split
       # ...
     end
   end
   ```

1. Submit address:

   ```crystal
   paystack.charges.submit_address(
     address: "140 N 2ND ST",
     reference: "5bwib5v6anhe9xa"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.fees
       puts transaction.domain
       puts transaction.customer
       # ...
     end
   end
   ```

1. Check charge status:

   ```crystal
   paystack.charges.check_status(reference: "zuvbpizfcf2fs7y") do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.currency
       puts transaction.created_at.try &.monday?
       puts transaction.channel
       # ...
     end
   end
   ```
