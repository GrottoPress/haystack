struct Haystack::Page
  include JSON::Serializable

  getter active : Bool | Int32 | Nil
  getter amount : Int64?
  getter collect_phone : Bool | Int32 | Nil
  getter createdAt : Time?
  getter currency : Currency?
  getter custom_fields : Array(CustomField)?
  getter description : String?
  getter domain : Domain?
  getter id : Int64?
  getter integration : Integration | Int64 | Nil
  getter metadata : Metadata | JSON::Any | Nil
  getter migrate : Bool | Int32 | Nil
  getter name : String?
  getter notification_email : String?
  getter plan : Plan | String | Int64 | Nil
  getter products : Array(Product)?
  getter published : Bool | Int32 | Nil
  getter redirect_url : String?
  getter slug : String?
  getter split_code : String?
  getter success_message : String?
  getter type : Type?
  getter updatedAt : Time?
end
