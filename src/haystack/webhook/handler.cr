module Haystack::Webhook::Handler
  macro included
    include HTTP::Handler

    def initialize(@secret_key : String, @path : String)
    end

    def call(context)
      request, response = context.request, context.response

      if request.path != @path || request.method != "POST"
        return call_next(context)
      end

      return response.status_code = 403 unless verify?(request)

      response.status_code = 200
      call(request.body)
    end

    private def verify?(request) : Bool
      return false unless signature = request.headers["X-Paystack-Signature"]?

      digest = Digest::SHA512.hexdigest(@secret_key)
      Crypto::Subtle.constant_time_compare(digest, signature)
    end

    private def call(body : IO?)
      return unless body

      webhook = Haystack::Webhook.from_json(body)
      event, data = webhook.event, webhook.data

      case
      when event.charge.dispute?
        call(event.charge.dispute, data.as(Haystack::Dispute))
      when event.charge?
        call(event.charge, data.as(Haystack::Transaction))
      when event.customeridentification?
        call(
          event.customeridentification,
          data.as(Haystack::Webhook::CustomerIdentification)
        )
      when event.invoice?
        call(event.invoice, data.as(Haystack::Subscription::Invoice))
      when event.paymentrequest?
        call(event.paymentrequest, data.as(Haystack::Invoice))
      when event.subscription?
        call(event.subscription, data.as(Haystack::Subscription))
      when event.transfer?
        call(event.transfer, data.as(Haystack::Transfer))
      end
    end

    private def call(
      event : Haystack::Webhook::Event::CustomerIdentification,
      data : Haystack::Webhook::CustomerIdentification
    )
    end

    private def call(
      event : Haystack::Webhook::Event::Charge::Dispute,
      data : Haystack::Dispute
    )
    end

    private def call(
      event : Haystack::Webhook::Event::PaymentRequest,
      data : Haystack::Invoice
    )
    end

    private def call(
      event : Haystack::Webhook::Event::Invoice,
      data : Haystack::Subscription::Invoice
    )
    end

    private def call(
      event : Haystack::Webhook::Event::Subscription,
      data : Haystack::Subscription
    )
    end

    private def call(
      event : Haystack::Webhook::Event::Charge,
      data : Haystack::Transaction
    )
    end

    private def call(
      event : Haystack::Webhook::Event::Transfer,
      data : Haystack::Transfer
    )
    end
  end
end
