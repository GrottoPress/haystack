struct Haystack::Webhook::Event
  getter raw : String

  def initialize(@raw)
  end

  def charge
    Charge.new(@raw)
  end

  def charge?
    @raw.starts_with?("#{Charge::NAME}.")
  end

  def customeridentification
    CustomerIdentification.new(@raw)
  end

  def customeridentification?
    @raw.starts_with?("#{CustomerIdentification::NAME}.")
  end

  def invoice
    Invoice.new(@raw)
  end

  def invoice?
    @raw.starts_with?("#{Invoice::NAME}.")
  end

  def paymentrequest
    PaymentRequest.new(@raw)
  end

  def paymentrequest?
    @raw.starts_with?("#{PaymentRequest::NAME}.")
  end

  def subscription
    Subscription.new(@raw)
  end

  def subscription?
    @raw.starts_with?("#{Subscription::NAME}.")
  end

  def transfer
    Transfer.new(@raw)
  end

  def transfer?
    @raw.starts_with?("#{Transfer::NAME}.")
  end

  struct Charge
    NAME = "charge"

    SUCCESS = "#{NAME}.success"

    def initialize(@raw : String)
    end

    def dispute
      Dispute.new(@raw)
    end

    def dispute?
      @raw.starts_with?("#{Dispute::NAME}.")
    end

    def success?
      @raw == SUCCESS
    end

    struct Dispute
      NAME = "#{Charge::NAME}.dispute"

      CREATE = "#{NAME}.create"
      REMIND = "#{NAME}.remind"
      RESOLVE = "#{NAME}.resolve"

      def initialize(@raw : String)
      end

      def create?
        @raw == CREATE
      end

      def remind?
        @raw == REMIND
      end

      def resolve?
        @raw == RESOLVE
      end
    end
  end

  struct CustomerIdentification
    NAME = "customeridentification"

    FAILED = "#{NAME}.failed"
    SUCCESS = "#{NAME}.success"

    def initialize(@raw : String)
    end

    def failed?
      @raw == FAILED
    end

    def success?
      @raw == SUCCESS
    end
  end

  struct Invoice
    NAME = "invoice"

    CREATE = "#{NAME}.create"
    PAYMENT_FAILED = "#{NAME}.payment_failed"
    UPDATE = "#{NAME}.update"

    def initialize(@raw : String)
    end

    def create?
      @raw == CREATE
    end

    def payment_failed?
      @raw == PAYMENT_FAILED
    end

    def update?
      @raw == UPDATE
    end
  end

  struct PaymentRequest
    NAME = "paymentrequest"

    PENDING = "#{NAME}.pending"
    SUCCESS = "#{NAME}.success"

    def initialize(@raw : String)
    end

    def pending?
      @raw == PENDING
    end

    def success?
      @raw == SUCCESS
    end
  end

  struct Subscription
    NAME = "subscription"

    CREATE = "#{NAME}.create"
    DISABLE = "#{NAME}.disable"
    ENABLE = "#{NAME}.enable"

    def initialize(@raw : String)
    end

    def create?
      @raw == CREATE
    end

    def disable?
      @raw == DISABLE
    end

    def enable?
      @raw == ENABLE
    end
  end

  struct Transfer
    NAME = "transfer"

    FAILED = "#{NAME}.failed"
    REVERSED = "#{NAME}.reversed"
    SUCCESS = "#{NAME}.success"

    def initialize(@raw : String)
    end

    def failed?
      @raw == FAILED
    end

    def reversed?
      @raw == REVERSED
    end

    def success?
      @raw == SUCCESS
    end
  end
end
