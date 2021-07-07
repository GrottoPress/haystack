struct Haystack::Subaccount
  include JSON::Serializable

  getter account_number : String?
  getter active : Bool | Int32 | Nil
  getter business_name : String?
  getter createdAt : Time?
  getter description : String?
  getter domain : Domain?
  getter id : Int64?
  getter migrate : Bool | Int32 | Nil
  getter integration : Integration | Int64 | Nil
  getter is_verified : Bool | Int32 | Nil
  getter metadata : Metadata | JSON::Any | Nil
  getter percentage_charge : Float64?
  getter primary_contact_email : String?
  getter primary_contact_name : String?
  getter primary_contact_phone : String?
  getter settlement_bank : String?
  getter settlement_schedule : Settlement::Schedule?
  getter subaccount_code : String?
  getter updatedAt : Time?
end
