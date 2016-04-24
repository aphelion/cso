class ProductPurchase < ActiveRecord::Base
  belongs_to :charge
  belongs_to :product

  validates :quantity, numericality: {greater_than_or_equal_to: 1}
end
