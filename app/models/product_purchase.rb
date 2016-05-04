class ProductPurchase < ActiveRecord::Base
  belongs_to :charge
  belongs_to :product
  has_many :product_purchase_option_choices

  accepts_nested_attributes_for :product_purchase_option_choices

  validates :quantity, numericality: {greater_than_or_equal_to: 1}

  def total_price
    return 0 if product.nil?
    product.price * quantity
  end
end
