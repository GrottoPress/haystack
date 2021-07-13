struct Haystack::Transaction::Source
  include Hapi::Resource

  getter source : String
  getter type : String
  getter identifier : JSON::Any # 'null' - Figure out type
  getter entry_point : String
end
