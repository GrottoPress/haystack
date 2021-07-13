struct Haystack::Transfer
  include Hapi::Resource

  @integration : Integration | Int64 | Nil
  @recipient : Recipient | Int64 | String | Nil

  getter amount : Int64?
  getter createdAt : Time?
  getter currency : Currency?
  getter domain : Domain?
  getter failures : JSON::Any? # Figure out type
  getter id : Int64?
  getter reason : String?
  getter reference : String?
  getter source : Source?
  getter source_details : JSON::Any? # Figure out type
  getter status : Status?
  getter titan_code : String?
  getter transfer_code : String?
  getter transferred_at : Time?
  getter updatedAt : Time?

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def recipient : Recipient?
    Recipient.from_any(@recipient)
  end
end
