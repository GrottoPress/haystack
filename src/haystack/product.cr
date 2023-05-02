struct Haystack::Product
  include Haystack::Resource

  @active : ::Bool | Int32 | Nil
  @in_stock : ::Bool | Int32 | Nil
  @integration : Integration | Int64 | Nil
  @is_shippable : ::Bool | Int32 | Nil
  @metadata : Metadata | JSON::Any | Nil
  @unlimited : ::Bool | Int32 | Nil

  getter currency : Currency?
  getter description : String?
  getter domain : Domain?
  getter features : JSON::Any? # Figure out type
  getter file_path : String?
  getter files : Array(File)?
  getter id : Int64?
  getter image_path : String?
  getter maximum_orderable : Int32?
  getter minimum_orderable : Int32?
  getter name : String?
  getter notification_emails : JSON::Any? # Figure out type
  getter price : Int32?
  getter product_code : String?
  getter quantity : Int32?
  getter quantity_sold : Int32?
  getter redirect_url : String?
  getter slug : String?
  getter split_code : String?
  getter success_message : String?
  getter type : Type?
  getter variant_options : Array(JSON::Any)? # Figure out type

  Haystack.time_field :created, :updated

  def integration : Integration?
    Integration.from_any(@integration)
  end

  def metadata : Metadata?
    Metadata.from_any(@metadata)
  end

  def active
    active?
  end

  def in_stock
    in_stock?
  end

  def is_shippable
    is_shippable?
  end

  def unlimited
    unlimited?
  end

  def active?
    Bool.from_any(@active)
  end

  def in_stock?
    Bool.from_any(@in_stock)
  end

  def is_shippable?
    Bool.from_any(@is_shippable)
  end

  def unlimited?
    Bool.from_any(@unlimited)
  end
end
