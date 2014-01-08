# serializer for category json
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :cid, :name

  def id
    object.id.to_s
  end
end
