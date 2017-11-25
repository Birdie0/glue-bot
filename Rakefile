# frozen_string_literal: true

task default: :run

desc 'install requirements'
task :install do
  sh 'gem install bundler --conservative'
  sh 'bundle update'
end

desc 'update from github repo'
task :update do
  sh 'git pull'
end

desc 'run bot'
task :run do
  sh 'bundle exec ruby run.rb'
end

desc 'run bot cycle'
task :runme do
  loop do
    Rake::Task['update'].invoke
    Rake::Task['install'].invoke
    Rake::Task['run'].invoke
  end
end
