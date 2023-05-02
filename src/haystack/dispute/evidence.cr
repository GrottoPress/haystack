class Haystack::Dispute::Evidence
  include Haystack::Resource
  include FromAny

  @dispute : Dispute | Int64 | Nil

  getter customer_email : String?
  getter customer_name : String?
  getter customer_phone : String?
  getter delivery_address : String?
  getter delivery_date : Time?
  getter id : Int64?
  getter service_details : String?

  Haystack.time_field :created, :updated

  def dispute : Dispute?
    Dispute.from_any(@dispute)
  end

  struct Item
    include Response

    getter data : Evidence?
  end
end
