enum Haystack::Transaction::Status
  Success
  Failed
  Ongoing
  Abandoned
  Reversed

  # These are for when checking pending charges
  SendOtp
  Pending
  SendPin
  # Failed
  OpenUrl
  SendPhone
  SendBirthday
end
