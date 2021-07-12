class Haystack::Bank::Account
  include JSON::Serializable

  @active : ::Bool | Int32 | Nil
  @assigned : ::Bool | Int32 | Nil
  @customer : Customer | Int64 | Nil
  @metadata : Metadata | JSON::Any | Nil

  getter account_name : String?
  getter account_number : String?
  getter assignment : Assignment?
  getter bank : Bank?
  getter created_at : Time?
  getter createdAt : Time?
  getter currency : Currency?
  getter id : Int64?
  getter provider : Provider?
  getter split_config : Split?
  getter updated_at : Time?
  getter updatedAt : Time?

  def customer : Customer?
    Customer.from_any(@customer)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def active
    active?
  end

  def assigned
    assigned?
  end

  def active?
    Bool.from_any(@active)
  end

  def assigned?
    Bool.from_any(@assigned)
  end

  struct Assignment
    include JSON::Serializable

    @expired : ::Bool | Int32 | Nil
    @integration : Integration | Int64 | Nil

    getter account_type : String?
    getter assigned_at : Time?
    getter assignee_id : Int64?
    getter assignee_type : String?

    def integration : Integration?
      Integration.from_any(@integration)
    end

    def expired
      expired?
    end

    def expired?
      Bool.from_any(@expired)
    end
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
