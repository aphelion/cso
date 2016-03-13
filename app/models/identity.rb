class Identity < ActiveRecord::Base
  belongs_to :user
  enum provider: [:facebook, :google]

  def self.find_or_create_by_omniauth(auth_hash)
    auth_hash = auth_hash.with_indifferent_access
    find_or_create_by(uid: auth_hash[:uid], provider: Identity.providers[auth_hash[:provider]])
  end
end
