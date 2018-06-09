# gem install bundler --conservative
git stash save -u
git pull
bundle update
bundle exec ruby run.rb
