struct Haystack::Transfer
  include Hapi::Resource

  @integration : Integration | Int64 | Nil
  @recipient : Recipient | Int64 | String | Nil

  getter amount : Int32?
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

  Haystack.time_field :created, :transferred, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def recipient : Recipient?
    Recipient.from_any(@recipient)
  end
end
