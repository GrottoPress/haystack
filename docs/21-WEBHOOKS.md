## Webhooks

*Haystack* comes with a webhook handler, an HTTP handler that intercepts webhook events from *Paystack* and allows you to perform actions based on the type of event received.

See <https://paystack.com/docs/payments/webhooks>

### Usage

1. Create HTTP handler:

   ```crystal
   class PaystackWebhookHandler
     include Haystack::Webhook::Handler # <= (Required)

     # This method runs when a "customeridentification.*" event is received.
     #
     # Events:
     #
     # - `customeridentificaiton.success?`
     # - `customeridentificaiton.failed?`
     private def call(
       event : Haystack::Webhook::Event::CustomerIdentification,
       data : Haystack::Webhook::CustomerIdentification
     )
       case event
       when .success?
         do_something(data)
       when .failed?
         do_something_else(data)
       end
     end

     # This method runs when a "charge.dispute.*" event is received.
     #
     # Events:
     #
     # - `charge.dispute.create?`
     # - `charge.dispute.remind?`
     # - `charge.dispute.resolve?`
     private def call(
       event : Haystack::Webhook::Event::Charge::Dispute,
       data : Haystack::Dispute
     )
       case event
       when .create?
         do_something(data)
       when .remind?
         do_something_else(data)
       when .resolve?
         do_another_thing(data)
       end
     end

     # This method runs when a "paymentrequest.*" event is received.
     #
     # Events:
     #
     # - `paymentrequest.success?`
     # - `paymentrequest.pending?`
     private def call(
       event : Haystack::Webhook::Event::PaymentRequest,
       data : Haystack::Invoice
     )
       case event
       when .success?
         do_something(data)
       when .pending?
         do_something_else(data)
       end
     end

     # This method runs when a "invoice.*" event is received.
     #
     # Events:
     #
     # - `invoice.create?`
     # - `invoice.payment_failed?`
     # - `invoice.update?`
     private def call(
       event : Haystack::Webhook::Event::Invoice,
       data : Haystack::Subscription::Invoice
     )
       case event
       when .create?
         do_something(data)
       when .payment_failed?
         do_something_else(data)
       when .update?
         do_another_thing(data)
       end
     end

     # This method runs when a "subscription.*" event is received.
     #
     # Events:
     #
     # - `subscription.create?`
     # - `subscription.enable?`
     # - `subscription.disable?`
     private def call(
       event : Haystack::Webhook::Event::Subscription,
       data : Haystack::Subscription
     )
       case event
       when .create?
         do_something(data)
       when .enable?
         do_something_else(data)
       when .disable?
         do_another_thing(data)
       end
     end

     # This method runs when a "charge.*" event is received.
     #
     # Events:
     #
     # - `charge.success?`
     private def call(
       event : Haystack::Webhook::Event::Charge,
       data : Haystack::Transaction
     )
       case event
       when .success?
         do_something(data)
       end
     end

     # This method runs when a "transfer.*" event is received.
     #
     # Events:
     #
     # - `transfer.success?`
     # - `transfer.failed?`
     # - `transfer.reversed?`
     private def call(
       event : Haystack::Webhook::Event::Transfer,
       data : Haystack::Transfer
     )
       case event
       when .success?
         do_something(data)
       when .failed?
         do_something_else(data)
       when .reversed?
         do_another_thing(data)
       end
     end
   end
   ```

   It is not required to define all handler methods; just the ones for events you want to handle. *Haystack* would silently ignore any unhandled events.

1. Use the handler:

   You may use your handler anywhere `HTTP::Handler` is acceptable, including middlewares/pipes in most web application frameworks.

   The example below uses `HTTP::Server` from the standard library:

   ```crystal
   paystack_webhook = PaystackWebhookHandler.new(
     secret_key: "secret-key",
     path: "/webhooks/paystack"
   )

   server = HTTP::Server.new([
     # ...
     paystack_webhook,
     # ...
   ])

   server.bind_tcp "127.0.0.1", 8080
   server.listen
   ```

   *Haystack* would intercept webhook events sent to `http://127.0.0.1:8080/webhooks/paystack`, and call the handler method you defined that corresponds to the event received.

   Be sure to add the handler **before** others that do some sort of authentication, such as CSRF handlers, or even route handlers.

   Preferrably, operations performed in any webhook handler method should be delegated to a background job. This should avoid potential timeouts, and allow a response to be returned immediately to *Paystack*.
