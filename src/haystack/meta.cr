struct Haystack::Meta
  include Hapi::Resource

  @pageCount : Int32?
  @perPage : Int32?

  getter next : String?
  getter page : Int32?
  getter previous : String?
  getter skipped : Int32?
  getter total : Int32?
  getter total_volume : Int64?

  def page_count
    @pageCount
  end

  def per_page
    @perPage
  end
end
