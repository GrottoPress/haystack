struct Haystack::Product
  include JSON::Serializable

  getter active : Bool | Int32 | Nil
  getter createdAt : Time?
  getter currency : Currency?
  getter description : String?
  getter domain : Domain?
  getter features : JSON::Any? # Figure out type
  getter file_path : String?
  getter files : Array(File)?
  getter id : Int64?
  getter image_path : String?
  getter in_stock : Bool | Int32 | Nil
  getter integration : Integration | Int64 | Nil
  getter is_shippable : Bool | Int32 | Nil
  getter maximum_orderable : Int32?
  getter metadata : Metadata | JSON::Any | Nil
  getter minimum_orderable : Int32?
  getter name : String?
  getter notification_emails : JSON::Any? # Figure out type
  getter price : Int64?
  getter product_code : String?
  getter quantity : Int32?
  getter quantity_sold : Int32?
  getter redirect_url : String?
  getter slug : String?
  getter split_code : String?
  getter success_message : String?
  getter type : Type?
  getter unlimited : Bool | Int32 | Nil
  getter updatedAt : Time?
  getter variant_options : Array(JSON::Any)? # Figure out type
end
