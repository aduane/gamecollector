Before do
  OmniAuth.config.test_mode = true
 
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:google_oauth2] = {
      "provider"=>"google_oauth2",
      "uid"=>"http://example.com/openid?id=118181138998978630963",
      "info"=>{"name"=>"Andrew"}
  }
end
 
After do
  OmniAuth.config.test_mode = false
end
