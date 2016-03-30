class Product < ActiveRecord::Base
  monetize :price_cents
end
