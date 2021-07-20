# Haystack

*Haystack* is a low-level API client for [*Paystack*](https://paystack.com). It features an intuitive interface that maps perfectly to the *Paystack* API.

*Haystack* comes with a webhook handler that intercepts events received from *Paystack*, and allows you to perform actions based on the event type.

### Usage Examples

1. Create client:

   ```crystal
   paystack = Haystack.new(secret_key: "secret-key")
   ```

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

1. Initialize transaction:

   ```crystal
   paystack.transactions.init(
     email: "customer@email.com",
     amount: "20000",
     currency: "GHS"
   ) do |response|
     return puts response.message unless response.success?

     response.data.try do |authorization|
       puts authorization.access_code
       puts authorization.authorization_url
       puts authorization.reference
     # ...
     end
   end
   ```

1. Verify transaction:

   ```crystal
   paystack.transactions.verify(reference: "abcdef") do |response|
     return puts response.message unless response.success?

     response.data.try do |transaction|
       puts transaction.status
       puts transaction.authorization.try &.authorization_code
       puts transaction.channel
     # ...
     end
   end
   ```

1. List invoices:

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

## Documentation

Find the complete documentation in the `docs/` directory of this repository.

## Development

1. Copy your **test** secret key from your [Paystack dashboard](https://dashboard.paystack.com).

1. Create a `.env.sh` file:

   ```bash
   #!/bin/bash
   #
   export PAYSTACK_SECRET_KEY='your-paystack-test-secret-key-here'
   ```

1. Update the file with your own details. Then run tests with `source .env.sh && crystal spec`.

**IMPORTANT**: Remember to set permissions for your env file to `0600` or stricter: `chmod 0600 .env*`.

## Contributing

1. [Fork it](https://github.com/GrottoPress/haystack/fork)
1. Switch to the `master` branch: `git checkout master`
1. Create your feature branch: `git checkout -b my-new-feature`
1. Make your changes, updating changelog and documentation as appropriate.
1. Commit your changes: `git commit`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a new *Pull Request* against the `GrottoPress:master` branch.
