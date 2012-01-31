namespace :site_errors do
  desc "Send site error logs for last hour to email"
  task :email => :environment do
    emails = %w(support@terrasoft.ru s.karlo@terrasoft.ru a.popov@terrasoft.ru)
    Mailer.site_errors(emails).deliver!
  end 
end