class Haystack::Bank::Account
  include JSON::Serializable

  getter account_name : String?
  getter account_number : String?
  getter active : Bool | Int32 | Nil
  getter assigned : Bool | Int32 | Nil
  getter assignment : Assignment?
  getter bank : Bank?
  getter created_at : Time?
  getter createdAt : Time?
  getter currency : Currency?
  getter customer : Customer | Int64 | Nil
  getter id : Int64?
  getter metadata : Metadata | JSON::Any | Nil
  getter provider : Provider?
  getter split_config : Split?
  getter updated_at : Time?
  getter updatedAt : Time?

  struct Assignment
    include JSON::Serializable

    getter account_type : String?
    getter assigned_at : Time?
    getter assignee_id : Int64?
    getter assignee_type : String?
    getter expired : Bool | Int32 | Nil
    getter integration : Integration | Int64 | Nil
  end

  struct Item
    include Response

    getter data : Account?
  end

  struct List
    include Response

    getter data : Array(Account)?
  end
end
