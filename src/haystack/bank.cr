struct Haystack::Bank
  include JSON::Serializable

  getter active : Bool | Int32 | Nil
  getter code : String?
  getter country : String?
  getter currency : Currency?
  getter createdAt : Time?
  getter gateway : Gateway?
  getter id : Int64?
  getter is_deleted : Bool | Int32 | Nil
  getter longcode : String?
  getter name : String?
  getter pay_with_bank : Bool | Int32 | Nil
  getter slug : String?
  getter type : Type?
  getter updatedAt : Time?
end
