
class YearSerializer < ActiveModel::Serializer
  attributes :id, :year
  def id
    object.year
  end
end