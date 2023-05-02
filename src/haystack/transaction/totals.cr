struct Haystack::Transaction::Totals
  include Haystack::Resource

  getter pending_transfers : Int64
  getter pending_transfers_by_currency : Array(Amount)
  getter total_transactions : Int64
  getter total_volume : Int64
  getter total_volume_by_currency : Array(Amount)
  getter unique_customers : Int64?

  struct Item
    include Response

    getter data : Totals?
  end
end
