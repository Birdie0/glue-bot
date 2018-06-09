# frozen_string_literal: true

task default: :run

desc 'install requirements'
task :install do
  sh 'gem install bundler --conservative'
  sh 'bundle update'
end

desc 'update from github repo'
task :update do
  sh 'git stash save -u'
  sh 'git pull'
end

desc 'run bot'
task :run do
  sh 'bundle exec ruby run.rb'
end

desc 'run bot in a loop'
task :runme do
  loop do
    Rake::Task['update'].execute
    Rake::Task['install'].execute
    Rake::Task['run'].execute
  end
end

desc 'run rubocop'
task :fix do
  sh 'rubocop -a'
end
