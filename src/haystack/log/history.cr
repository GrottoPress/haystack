struct Haystack::Log::History
  include Hapi::Resource

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
