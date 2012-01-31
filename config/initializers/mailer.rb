HyperCloud::Application.configure do
  config.action_mailer.default_url_options = {
    :protocol => "http",
    :host => "cloud.bpmonline.com"
  }
  config.action_mailer.delivery_method = :sendmail
end

ActionMailer::Base.delivery_method = :sendmail


