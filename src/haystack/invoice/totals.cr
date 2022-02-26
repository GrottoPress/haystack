struct Haystack::Invoice::Totals
  include Hapi::Resource

  getter pending : Array(Amount)
  getter successful : Array(Amount)
  getter total : Array(Amount)

  struct Item
    include Response

    getter data : Totals?
  end
end
