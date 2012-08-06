class Shop < ActiveRecord::Base
  attr_accessible :address, :business_type, :city, :country, :description, :phone, :state, :title
end
