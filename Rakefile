require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "stonepath"
    gemspec.summary = "Stonepath: stateful workflow modeling for rails"
    gemspec.description = "Stonepath: stateful workflow modeling for rails"
    gemspec.email = "dbock@codesherpas.com"
    gemspec.homepage = "http://github.com/bokmann/stonepath"
    gemspec.description = "TODO"
    gemspec.authors = ["David Bock"]
    gemspec.add_dependency('activerecord','>= 2.0.0')
  end
  
    Jeweler::GemcutterTasks.new
    
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test*.rb'
  t.verbose = false
end
 
 
Rcov::RcovTask.new do |t|
  #t.libs << "test"
  #t.test_files = FileList['./test/**/test*.rb']
  #t.verbose = true

  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
  #t.rcov_opts << "--no-color"
  #t.rcov_opts << "--save coverage.info"
  t.rcov_opts << "-x ^/"
end

task :default => :rcov