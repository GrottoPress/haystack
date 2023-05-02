struct Haystack::Log
  include Haystack::Resource

  @mobile : ::Bool | Int32 | Nil
  @success : ::Bool | Int32 | Nil

  getter attempts : Int32?
  getter authentication : String?
  getter channel : Channel?
  getter errors : Int32?
  getter history : Array(History)?
  getter input : Array(String)?
  getter start_time : Int64?
  getter time_spent : Int64?

  def mobile
    mobile?
  end

  def success
    success?
  end

  def mobile?
    Bool.from_any(@mobile)
  end

  def success?
    Bool.from_any(@success)
  end
end
