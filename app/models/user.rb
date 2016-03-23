class User < ActiveRecord::Base
  has_many :identities
  has_many :tickets
end
