Devise.setup do |config|
  config.mailer = 'Users::Mailer'

  config.mailer_sender = 'StudyDiary 認証メール<study_diary@gmail.com>'

  require 'devise/orm/active_record'

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..20

  config.timeout_in = 1.day

  config.confirm_within = 1.days

  config.reset_password_within = 6.hours

  config.scoped_views = true

  config.sign_out_via = :delete
end
