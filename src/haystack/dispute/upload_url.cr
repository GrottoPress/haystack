struct Haystack::Dispute::UploadUrl
  include Hapi::Resource

  getter fileName : String
  getter signedUrl : String

  struct Item
    include Response

    getter data : UploadUrl?
  end
end
