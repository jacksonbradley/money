
class Month
  include Mongoid::Document
  field :year, type: Integer
  field :month, type: Integer
  field :total, type: Integer

end