struct Haystack::Transaction::Source
  include JSON::Serializable

  getter source : String
  getter type : String
  getter identifier : JSON::Any # 'null' - Figure out type
  getter entry_point : String
end
