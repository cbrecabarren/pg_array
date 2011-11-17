# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "pg_array"
  gem.homepage = "http://github.com/cbrecabarren/pg_array"
  gem.license = "MIT"
  gem.summary = "Convert PostgreSQL arrays to Ruby arrays"
  gem.description = "..."
  gem.email = "cbrecabarren@gmail.com"
  gem.authors = ["Carlos Beltrán-Recabarren"]
  gem.files = FileList['lib/**/*', '[A-Z]*'].to_a
end

Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test
