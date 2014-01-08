
class TrendSerializer < ActiveModel::Serializer
  attributes :id, :total, :month, :category_id
  def id
    object.category_id.to_s + object.month.to_s
  end
end