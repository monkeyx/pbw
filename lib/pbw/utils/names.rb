require 'pbw/utils'

module Pbw
	module Utils
		class Names
		  def initialize(data_file)
		    @list = []
		    File.open(data_file, 'r') do |file|
		      while line = file.gets do
		        @list << line.strip.titleize
		      end
		    end
		    @list
		  end

		  def random_name
		    @list.sample
		  end
		end
	end
end