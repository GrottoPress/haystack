struct Haystack::Transaction::Timeline
  struct Item
    include Response

    getter data : Log?
  end
end
