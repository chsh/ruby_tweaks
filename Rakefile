require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "tweaks"
    gem.summary = %Q{Tweaks is a pack of various utility methods.}
    gem.description = %Q{It basicly needs rails environment. But you can use some tweaks without rails.}
    gem.email = "scene.sc@gmail.com"
    gem.homepage = "http://gems.thinq.jp/"
    gem.authors = ["CHIKURA Shinsaku"]
    gem.add_development_dependency "shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
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
  rdoc.title = "tweaks #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :thinq do
  desc "Publish gem to ThinQ private gem server."
  task :publish do
    version = File.read('VERSION').chomp
    gem_file = "tweaks-#{version}.gem"
    gem_path = "pkg/#{gem_file}"
    raise "gem doesn't exist." unless File.exist? gem_path
    cmd = "scp #{gem_path} gem-server@gems.thinq.jp:"
    puts "Running: #{cmd}"
    `#{cmd}`
    # cmd = "ssh gem-server@gems.thinq.jp '/opt/local/bin/gem install #{gem_file}; rm #{gem_file}'"
    cmd = "ssh gem-server@gems.thinq.jp 'GEM_HOME=~/repository /opt/local/bin/gem install #{gem_file}; rm #{gem_file}'"
    puts "Running: #{cmd}"
    `#{cmd}`
  end
end

