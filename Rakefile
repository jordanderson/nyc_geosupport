require "bundler/gem_tasks"
require "rake/testtask"
require 'pp'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
#  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

desc "Run console with nyc_geosupport gem loaded"
task :console do
  require 'irb'
  require 'irb/completion'
  require 'nyc_geosupport'
  ARGV.clear
  IRB.start
end

namespace :image do

  desc "Build Docker image"
  task :build do
    system "docker build -t nyc_geosupport ."
  end

  desc "Delete untagged Docker images (uses --force so be careful)"
  task :cleanup do
    `docker rmi --force $(docker images -q --filter "dangling=true")`
  end

  desc "List nyc_geosupport Docker images"
  task :list do
    system "docker images | grep nyc_geosupport"
  end
end

namespace :docker do
  desc "Test in Docker container"
  task :test do
    Rake::Task["image:build"].invoke
    system "docker run nyc_geosupport rake test"
  end

  desc "Run console in Docker container with nyc_geosupport gem loaded"
  task :console do
    Rake::Task["image:build"].invoke
    system "docker run -it nyc_geosupport rake console"
  end
end
