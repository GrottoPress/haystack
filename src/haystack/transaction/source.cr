struct Haystack::Transaction::Source
  include Haystack::Resource

  getter source : String
  getter type : String
  getter identifier : JSON::Any # Figure out type
  getter entry_point : String
end
