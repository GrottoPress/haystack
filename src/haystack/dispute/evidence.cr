class Haystack::Dispute::Evidence
  include JSON::Serializable

  getter createdAt : Time?
  getter customer_email : String?
  getter customer_name : String?
  getter customer_phone : String?
  getter delivery_address : String?
  getter delivery_date : Time?
  getter dispute : Dispute | Int64 | Nil
  getter id : Int64?
  getter service_details : String?
  getter updatedAt : Time?

  struct Item
    include Response

    getter data : Evidence?
  end
end
