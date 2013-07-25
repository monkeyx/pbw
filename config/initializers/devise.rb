Devise.setup do |config|
  require 'devise/orm/mongoid'
  config.sign_out_via = :delete
  config.router_name = :pbw
  DeviseController.respond_to :json
end
