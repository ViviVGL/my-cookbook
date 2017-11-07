class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@cookbook.com'
  layout 'mailer'
end
