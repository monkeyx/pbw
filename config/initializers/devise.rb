require 'devise/orm/mongoid'

Devise.setup do |config|
  config.router_name = :perens_instant_user
end