
class Trend
  include Mongoid::Document
  field :total, type: Integer
  field :month, type: Integer
  field :category_id, type: Integer

end