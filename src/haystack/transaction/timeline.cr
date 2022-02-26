struct Haystack::Transaction::Timeline
  struct Item
    include Response

    struct Resource
      getter data : Log?
    end
  end
end
