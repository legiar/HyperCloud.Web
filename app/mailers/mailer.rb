class Mailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  default :from => "HyperCloud <admin@bpmonline.com>"
  
  def monitoring_status(email = "")
    @status = Status.monitoring

    email = "m.mikhaliov@bpmonline.com" if email.empty?
    mail :to => email
  end
  
  def approve(record)
    devise_mail(record, :approved_inctruction)
  end
end
