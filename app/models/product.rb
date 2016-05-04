class Product < ActiveRecord::Base
  monetize :price_cents
  has_many :options, foreign_key: :product_id, class_name: 'ProductOption'

  accepts_nested_attributes_for :options
end
