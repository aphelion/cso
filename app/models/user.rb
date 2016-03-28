class User < ActiveRecord::Base
  has_many :identities
  has_many :tickets
  has_one :customer
end
