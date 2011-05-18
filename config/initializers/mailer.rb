HyperAdmin::Application.configure do
  config.action_mailer.default_url_options = {
    :protocol => "https",
    :host => "admin.bpmonline.com"
  }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "mail.tscrm.com",
    :authentication => false,
    :enable_starttls_auto => false
  }
end
