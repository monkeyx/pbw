module User
	class Lifecycle

		def self.after_signup(user)
			# do anything that needs to happen immediately after a user signs up
			user.make_superadmin! if Pbw::User.count == 1
		end

		def self.after_login(user)
			# do anything that needs to happen immediately after a user logs in
		end
		
	end
end