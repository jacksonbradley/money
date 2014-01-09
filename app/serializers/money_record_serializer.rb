# serializer for money record
class MoneyRecordSerializer < ActiveModel::Serializer
  attributes :id, :amount, :category_id,
             :description, :day, :month, :year
  # def total
  #   object.total if object.try(:total)
  # end

  # def attributes
  #   # Rails.logger.debug { options.to_yaml }
  #   # Rails.logger.debug { super.to_yaml }
  #   # Rails.logger.debug { object.to_yaml }
  #   # Rails.logger.debug { _attributes }
  #   # data = super
  #   data = {}

  #   # Put object's all attributes to data hash
  #   object.attributes.each do |k, v|
  #     data[k] = v #if object.try(k) && _attributes.key?(k.to_sym)
  #   end

  #   # remove nil attribute
  #   data.delete_if { |k, v| v.nil? }
  #   data
  #   # object.attributes.delete_if { |k, v| v.nil? }
  #   # object
  # end

  def id
    id = ''
    id += object.year.to_s if object.year.present?
    id += object.month.to_s if object.month.present?
    id += object.day.to_s if object.day.present?
    id += object.category_id.to_s if object.category_id.present?
    return id
    # object.id.to_s
  end
end
