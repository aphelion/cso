class IdentitiesService
  def identity_model
    Identity
  end

  def find_or_create_by_auth_hash(auth_hash)
    auth_hash = auth_hash.with_indifferent_access
    return nil unless auth_hash[:uid] and auth_hash[:provider]
    identity_model.find_or_create_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
  end
end
