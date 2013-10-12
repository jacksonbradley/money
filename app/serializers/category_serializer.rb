# serializer for category json
class CategorySerializer < ActiveModel::Serializer
  attributes :cid, :name
end
