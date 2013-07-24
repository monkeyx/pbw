namespace :pbw do
	desc "Runs ticks"
	task :ticks do
		Pbw::Tick.run
	end

	desc "Runs updates"
	task :updates do
		Pbw::Update.run
	end
end