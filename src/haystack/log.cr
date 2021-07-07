struct Haystack::Log
  include JSON::Serializable

  getter attempts : Int32?
  getter authentication : String?
  getter channel : Channel?
  getter errors : Int32?
  getter history : Array(History)?
  getter input : Array(String)?
  getter mobile : Bool | Int32 | Nil
  getter success : Bool | Int32 | Nil
  getter start_time : Int64?
  getter time_spent : Int64?
end
