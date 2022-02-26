struct Haystack::Invoice::Notification
  include Hapi::Resource

  enum Channel
    Email
  end

  getter sent_at : Time
  getter channel : Channel

  struct Item
    include Response

    struct Resource
      getter data : Notification?
    end
  end
end
