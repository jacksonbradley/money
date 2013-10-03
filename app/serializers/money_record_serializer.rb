class MoneyRecordSerializer < ActiveModel::Serializer
  attributes :id, :amount, :category_id, :description, :day, :month, :year, :total
  
  # def total
  #   object.total if object.try(:total)
  # end

  def attributes
    # Rails.logger.debug { options.to_yaml }
    #Rails.logger.debug { super.to_yaml }
    #Rails.logger.debug { self._attributes }
    #data = super
    data = {}

    ## Put object's all attributes to data hash
    object.attributes.each { |k, v| data[k] = v if object.try(k) && self._attributes.key?(k.to_sym) }

    ## remove nil attribute
    data.delete_if { |k, v| v.nil? }
    data
  end

end
