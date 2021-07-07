## Client

A *client* is responsible for querying all API *endpoints*, and returning *response*s from the API server.

You may instantiate a client using a pre-generated secret_key:

```crystal
paystack = Haystack.new(secret_key: "secret-key")
```

From here on, you are ready to query *endpoint*s using the `paystack` client you just created.
