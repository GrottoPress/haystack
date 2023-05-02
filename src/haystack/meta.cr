struct Haystack::Meta
  include Haystack::Resource

  @pageCount : Int32? # ameba:disable Style/VariableNames
  @perPage : Int32? # ameba:disable Style/VariableNames

  getter next : String?
  getter page : Int32?
  getter previous : String?
  getter skipped : Int32?
  getter total : Int32?
  getter total_volume : Int64?

  def page_count
    @pageCount # ameba:disable Style/VariableNames
  end

  def per_page
    @perPage # ameba:disable Style/VariableNames
  end
end
