struct Haystack::Integration
  include Haystack::Resource
  include FromAny

  @is_live : ::Bool | Int32 | Nil

  getter allowed_currencies : Array(Currency)?
  getter business_name : String?
  getter id : Int64?
  getter key : String?
  getter logo : String?
  getter name : String?

  def is_live
    is_live?
  end

  def is_live?
    Bool.from_any(@is_live)
  end
end
