## Countries

A country is represented as `Haystack::Country`.

See <https://paystack.com/docs/api/#miscellaneous-country> for the raw JSON schema.

### Usage Examples

1. List all countries:

   ```crystal
   paystack.countries.list(perPage: "20") do |response|
     return puts response.message unless response.success?

     response.data.try &.each do |country|
       puts country.name
       puts country.iso_code
       puts country.calling_code
       # ...
     end
   end
   ```
