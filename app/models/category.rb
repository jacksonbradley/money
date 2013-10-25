# present category
# class Category < ActiveRecord::Base

# end

class Category 
  include Mongoid::Document
  field :name, type: String
  field :cid, type: Integer
end