# encoding: utf-8

$:.unshift File.dirname(__FILE__)

require 'date'
require 'pathname'
require 'rake'
require 'rake/testtask'

$rootdir = Pathname.new(__FILE__).dirname
$gemspec = Gem::Specification.new do |s|
  s.name              = 'claus'
  s.version           = '0.2.0'
  s.date              = Date.today
  s.authors           = ['Bharanee Rathna']
  s.email             = ['deepfryed@gmail.com']
  s.summary           = 'simple hash / array based rule expression'
  s.description       = 'simple hash / array based rule matching engine'
  s.homepage          = 'http://github.com/deepfryed/claus'
  s.files             = Dir['{test,lib}/**/*.rb'] + %w(README.md)
  s.require_paths     = %w(lib)

  s.add_development_dependency('rake')
end

desc 'Generate gemspec'
task :gemspec do
  $gemspec.date = Date.today
  File.open("#{$gemspec.name}.gemspec", 'w') {|fh| fh.write($gemspec.to_ruby)}
end

Rake::TestTask.new(:test) do |test|
  test.libs   << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task default: :test
