class Commands::<%=class_name%>
	<% attributes.each do |attribute| -%>
	attr_accessor :<%=attribute.name%>
	<% end -%>
	attr_accessor :token

	def valid_token?(token)
		# define checks to make sure token is valid for this command
		false
	end

	def processes
		# specify the processes that is called by this command
		# return either a single object inheriting from Pbw::Process or an array of them
		# Example:
		# Process.where(name: 'Move')
	end
end