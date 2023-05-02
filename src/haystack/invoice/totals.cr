struct Haystack::Invoice::Totals
  include Haystack::Resource

  getter pending : Array(Amount)
  getter successful : Array(Amount)
  getter total : Array(Amount)

  struct Item
    include Response

    getter data : Totals?
  end
end
