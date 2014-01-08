
class Summary
  include Mongoid::Document
  field :total, type: Integer
  field :category_id, type: Integer
  
end