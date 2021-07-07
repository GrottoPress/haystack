struct Haystack::Dispute::UploadUrl
  include JSON::Serializable

  getter fileName : String
  getter signedUrl : String

  struct Item
    include Response

    getter data : UploadUrl?
  end
end
