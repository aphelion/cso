class Identity < ActiveRecord::Base
  belongs_to :user
  enum provider: [:facebook, :google]
end
