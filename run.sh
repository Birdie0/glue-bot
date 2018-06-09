# gem install bundler --conservative
git stash save -u
git pull
bundle update --quiet
bundle exec ruby run.rb
