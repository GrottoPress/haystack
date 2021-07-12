struct Haystack::Bool
  def self.from_any(value) : ::Bool?
    case value
    when Number
      value.zero? ? false : true
    when String
      return false if value.empty?
      value.to_i?.try(&.zero?) ? false : true
    else
      value
    end
  end
end
