struct Haystack::Webhook::Event
  def initialize(@raw : String)
  end

  def charge
    Charge.new(@raw)
  end

  def charge?
    @raw.starts_with?("charge.")
  end

  def customeridentification
    CustomerIdentification.new(@raw)
  end

  def customeridentification?
    @raw.starts_with?("customeridentification.")
  end

  def invoice
    Invoice.new(@raw)
  end

  def invoice?
    @raw.starts_with?("invoice.")
  end

  def paymentrequest
    PaymentRequest.new(@raw)
  end

  def paymentrequest?
    @raw.starts_with?("paymentrequest.")
  end

  def subscription
    Subscription.new(@raw)
  end

  def subscription?
    @raw.starts_with?("subscription.")
  end

  def transfer
    Transfer.new(@raw)
  end

  def transfer?
    @raw.starts_with?("transfer.")
  end

  struct Charge
    def initialize(@event : String)
    end

    def dispute
      Dispute.new(@event)
    end

    def dispute?
      @event.starts_with?("charge.dispute.")
    end

    def success?
      @event == "charge.success"
    end

    struct Dispute
      def initialize(@event : String)
      end

      def create?
        @event == "charge.dispute.create"
      end

      def remind?
        @event == "charge.dispute.remind"
      end

      def resolve?
        @event == "charge.dispute.resolve"
      end
    end
  end

  struct CustomerIdentification
    def initialize(@event : String)
    end

    def failed?
      @event == "customeridentification.failed"
    end

    def success?
      @event == "customeridentification.success"
    end
  end

  struct Invoice
    def initialize(@event : String)
    end

    def create?
      @event == "invoice.create"
    end

    def payment_failed?
      @event == "invoice.payment_failed"
    end

    def update?
      @event == "invoice.update"
    end
  end

  struct PaymentRequest
    def initialize(@event : String)
    end

    def pending?
      @event == "paymentrequest.pending"
    end

    def success?
      @event == "paymentrequest.success"
    end
  end

  struct Subscription
    def initialize(@event : String)
    end

    def create?
      @event == "subscription.create"
    end

    def disable?
      @event == "subscription.disable"
    end

    def enable?
      @event == "subscription.enable"
    end
  end

  struct Transfer
    def initialize(@event : String)
    end

    def failed?
      @event == "transfer.failed"
    end

    def reversed?
      @event == "transfer.reversed"
    end

    def success?
      @event == "transfer.success"
    end
  end
end
