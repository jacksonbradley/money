class Category < ActiveRecord::Base
  def as_json(options)
    super(:only => [:cid, :name])
  end
end
