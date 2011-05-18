require 'test_helper'

class MailerTest < ActionMailer::TestCase
  test "monitoring_status" do
    mail = Mailer.monitoring_status
    assert_equal "Monitoring status", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
