
class YearSerializer < ActiveModel::Serializer
  attributes :id, :year
  def id
    object.year.to_s
  end
end