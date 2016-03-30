class User < ActiveRecord::Base
  has_many :identities
  has_one :customer
end
