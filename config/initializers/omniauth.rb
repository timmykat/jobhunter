Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GOOGLE_CONFIG['google_oauth2']['client_id'], GOOGLE_CONFIG['google_oauth2']['client_secret'],  
    {
      :scope => 'userinfo.profile,userinfo.email,https://www.googleapis.com/auth/calendar,https://www.googleapis.com/auth/calendar.readonly, https://www.google.com/m8/feeds',
      :prompt => 'consent'
    }
end
