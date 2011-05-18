class Mailer < ActionMailer::Base
  default :from => "HyperAdmin <hyperadmin@zabbix.bpmonline.com>"
  
  def monitoring_status(email = "")
    @status = Status.monitoring

    email = "m.mikhaliov@bpmonline.com" if email.empty?
    mail :to => email
  end
end
