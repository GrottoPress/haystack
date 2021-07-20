class TestWebhookHandler
  include Haystack::Webhook::Handler

  private def call(
    event : Haystack::Webhook::Event::CustomerIdentification,
    data : Haystack::Webhook::CustomerIdentification
  )
    event.success? ? 0 : 1
  end

  private def call(
    event : Haystack::Webhook::Event::Charge::Dispute,
    data : Haystack::Dispute
  )
    case event
    when .create?
      10
    when .remind?
      11
    when .resolve?
      12
    end
  end

  private def call(
    event : Haystack::Webhook::Event::PaymentRequest,
    data : Haystack::Invoice
  )
    event.success? ? 100 : 101
  end

  private def call(
    event : Haystack::Webhook::Event::Invoice,
    data : Haystack::Subscription::Invoice
  )
    case event
    when .create?
      1000
    when .payment_failed?
      1001
    when .update?
      1002
    end
  end

  private def call(
    event : Haystack::Webhook::Event::Subscription,
    data : Haystack::Subscription
  )
    case event
    when .create?
      10_000
    when .enable?
      10_001
    when .disable?
      10_002
    end
  end

  private def call(
    event : Haystack::Webhook::Event::Charge,
    data : Haystack::Transaction
  )
    event.success? ? 100_000 : 100_001
  end

  private def call(
    event : Haystack::Webhook::Event::Transfer,
    data : Haystack::Transfer
  )
    case event
    when .success?
      1_000_000
    when .failed?
      1_000_001
    when .reversed?
      1_000_002
    end
  end
end
