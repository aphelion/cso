class ProductPurchase < ActiveRecord::Base
  belongs_to :charge
  belongs_to :product
end
