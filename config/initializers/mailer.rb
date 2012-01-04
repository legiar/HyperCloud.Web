HyperCloud::Application.configure do
  config.action_mailer.default_url_options = {
    :protocol => "http",
    :host => "cloud.bpmonline.com"
  }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "smtp.bpmonline.com",
    :authentication => false,
    :enable_starttls_auto => false
  }
end
