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
  
  def site_errors(emails)
    addresses = emails.to_a.flatten
    @sites = SiteError.recent.group(:site).order(:site).count
    mail :subject => "BPMonline OnDemand: Last hour site errors", :to => addresses.first, :cc => addresses[1..-1] 
  end
end
