struct Haystack::Invoice::Notification
  include Haystack::Resource

  enum Channel
    Email
  end

  getter sent_at : Time
  getter channel : Channel

  struct Item
    include Response

    getter data : Notification?
  end
end
