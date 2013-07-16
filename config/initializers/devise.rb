Devise.setup do |config|
  #config.mailer_sender = Pbw::Engine.config.mail_sender

  config.mailer = "Devise::Mailer"

  require 'devise/orm/mongoid'

  config.authentication_keys = [ :email ]

  config.request_keys = []

  config.case_insensitive_keys = [ :email ]

  config.strip_whitespace_keys = [ :email ]

  config.params_authenticatable = true

  config.http_authenticatable = false

  config.http_authenticatable_on_xhr = true

  config.http_authentication_realm = "Application"

  config.paranoid = true

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.pepper = "63818839cfabfff3dcf5983671b4d2f01708727af5d512fd79a8afe7e744187a8976280cd31e8d1b023c2c29f4f396810c90ef15de5faaa20595e84bee4c9545"

  config.allow_unconfirmed_access_for = 2.days

  config.confirm_within = 3.days

  config.reconfirmable = true

  config.confirmation_keys = [ :email ]

  config.remember_for = 2.weeks

  config.extend_remember_period = false

  config.rememberable_options = {}

  config.password_length = 8..128

  config.email_regexp = /\A[^@]+@[^@]+\z/

  config.timeout_in = 30.minutes

  config.expire_auth_token_on_timeout = false

  config.lock_strategy = :failed_attempts

  config.unlock_keys = [ :email ]

  config.unlock_strategy = :email

  config.maximum_attempts = 5

  config.reset_password_keys = [ :email ]

  config.reset_password_within = 6.hours

  config.token_authentication_key = :auth_token

  config.scoped_views = false

  config.default_scope = :user

  config.sign_out_all_scopes = true

  config.navigational_formats = ["*/*", :html]

  config.sign_out_via = :delete

  config.router_name = :pbw
end
