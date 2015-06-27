Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  # Don't load images
  config.skip_image_loading
end
