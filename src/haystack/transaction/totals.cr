struct Haystack::Transaction::Totals
  include Hapi::Resource

  getter pending_transfers : Int64
  getter pending_transfers_by_currency : Array(Amount)
  getter total_transactions : Int64
  getter total_volume : Int64
  getter total_volume_by_currency : Array(Amount)
  getter unique_customers : Int64?

  struct Item
    include Response

    struct Resource
      getter data : Totals?
    end
  end
end
