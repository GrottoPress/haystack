struct Haystack::Dispute::UploadUrl
  include Hapi::Resource

  @fileName : String
  @signedUrl : String

  def file_name
    @fileName
  end

  def signed_url
    @signedUrl
  end

  struct Item
    include Response

    getter data : UploadUrl?
  end
end
