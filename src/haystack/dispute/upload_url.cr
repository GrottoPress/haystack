struct Haystack::Dispute::UploadUrl
  include Hapi::Resource

  @fileName : String # ameba:disable Style/VariableNames
  @signedUrl : String # ameba:disable Style/VariableNames

  def file_name
    @fileName # ameba:disable Style/VariableNames
  end

  def signed_url
    @signedUrl # ameba:disable Style/VariableNames
  end

  struct Item
    include Response

    struct Resource
      getter data : UploadUrl?
    end
  end
end
