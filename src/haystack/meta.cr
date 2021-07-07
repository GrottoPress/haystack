struct Haystack::Meta
  include JSON::Serializable

  getter next : String?
  getter page : Int32?
  getter pageCount : Int32?
  getter perPage : Int32?
  getter previous : String?
  getter skipped : Int32?
  getter total : Int32?
  getter total_volume : Int64?
end
