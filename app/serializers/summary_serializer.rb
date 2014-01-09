
class SummarySerializer < ActiveModel::Serializer
  attributes :id, :total, :category_id
  def id
    object.category_id.to_s
  end
end