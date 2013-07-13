begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PBW'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :backbone do
  desc "Download the latest released versions of underscore and backbone.js"
  task :download_latest do
    files = {
      'underscore.js'=>'http://underscorejs.org/underscore.js',
      'backbone.js' => 'http://backbonejs.org/backbone.js'
    }
    
    vendor_dir = "vendor/assets/javascripts"

    require 'open-uri'
    files.each do |local,remote|
      puts "Downloading #{local}"
      File.open "#{vendor_dir}/#{local}", 'w' do |f|
        f.write open(remote).read
      end
    end
  end
end


Bundler::GemHelper.install_tasks

