
class MonthSerializer < ActiveModel::Serializer
  attributes :id, :month, :total
  def id
    object.year.to_s + object.month.to_s
  end
end