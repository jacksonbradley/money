# serializer for money record
class MoneyRecordSerializer < ActiveModel::Serializer
  attributes :id, :amount, :category_id,
             :description, :day, :month, :year, :total
  # def total
  #   object.total if object.try(:total)
  # end

  def attributes
    # Rails.logger.debug { options.to_yaml }
    # Rails.logger.debug { super.to_yaml }
    # Rails.logger.debug { object.attributes }
    # Rails.logger.debug { _attributes }
    # data = super
    data = {}

    # Put object's all attributes to data hash
    object.attributes.each do |k, v|
      data[k] = v if object.try(k) && _attributes.key?(k.to_sym)
    end

    # remove nil attribute
    data.delete_if { |k, v| v.nil? }
    data
  end

end
