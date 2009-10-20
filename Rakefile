require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "html_press"
    gem.summary = %Q{API and Rack middleware for HTML compression with caching support.}
    gem.description = %Q{This middleware aims to compress the crap out of your HTML on-the-fly. It squeezes out every last kilobyte of traffic for your users. In some cases it can save ~50kb per request which may amount to 5 seconds of wait for a dial up user somewhere in the world. To prevent re-compressing on every request it uses checksum-based caching mechnism easily swappable for any key-value store. Among unique awesome features HTMLPress is smart enough to ignore rails authenticity tokens when it caches HTML. This avoids constant re-compressing on form pages.}
    gem.email = "max@bitsonnet.com"
    gem.homepage = "http://github.com/maxim/html_press"
    gem.authors = ["Maxim Chernyak"]
    gem.add_dependency "hpricot", ">=0.8"
    gem.add_development_dependency "shoulda", ">= 0"
    gem.files.include %w(lib/*/**)
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "html_press #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
