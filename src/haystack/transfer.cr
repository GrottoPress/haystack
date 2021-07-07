struct Haystack::Transfer
  include JSON::Serializable

  getter amount : Int64?
  getter createdAt : Time?
  getter currency : Currency?
  getter domain : Domain?
  getter failures : JSON::Any? # Figure out type
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter reason : String?
  getter recipient : Recipient | Int64 | String | Nil
  getter reference : String?
  getter source : Source?
  getter source_details : JSON::Any? # Figure out type
  getter status : Status?
  getter titan_code : String?
  getter transfer_code : String?
  getter transferred_at : Time?
  getter updatedAt : Time?
end
