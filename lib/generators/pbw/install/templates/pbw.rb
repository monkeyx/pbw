Pbw::Engine.config do |config|
	# User lifecycle class
	# default is generated class from rails g pbw:install
	# if you use another class it needs to implement the following:
	# def self.after_signup(user)
	# 	# do anything that needs to happen immediately after a user signs up
	# end
	# def self.after_login(user)
	# 	# do anything that needs to happen immediately after a user logs in
	# end
	config.user_lifecycle_class = User::Lifecycle
end