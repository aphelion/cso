class User < ActiveRecord::Base
  has_many :identities
  has_one :customer

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end
end
