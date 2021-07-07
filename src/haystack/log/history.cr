struct Haystack::Log::History
  include JSON::Serializable

  enum Type
    Input
    Action
    Auth
    Success
    Error
    Open
    Close
  end

  getter message : String
  getter time : Int32
  getter type : Type
end
