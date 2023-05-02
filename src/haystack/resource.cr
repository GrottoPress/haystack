module Haystack::Resource
  macro included
    include JSON::Serializable
  end
end
