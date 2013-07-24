Pbw.setup do |config|
	# the user class for Devise - if you replace this don't forget to setup the authorisation methods 
	# def self.viewable_by?(user, subject)
    #     true
    # end
    # def self.creatable_by?(user, subject)
    #     true
    # end
    # def self.editable_by?(user, subject)
    #     user.admin? || subject == user
    # end
    # def self.deletable_by?(user, subject)
    #     user.admin?
    # end
	config.user_class = Pbw::User

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