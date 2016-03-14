Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           ENV['FACEBOOK_KEY'],
           ENV['FACEBOOK_SECRET'],
           request_path: '/sessions/facebook',
           callback_path: '/sessions/facebook/callback',
           info_fields: 'email, first_name, last_name'

  provider :google_oauth2,
           ENV['GOOGLE_KEY'],
           ENV['GOOGLE_SECRET'],
           request_path: '/sessions/google',
           callback_path: '/sessions/google/callback',
           name: 'google'
end
