# remove old gems
rm -rf vendor Gemfile.lock

# installing gems into vendor dir
bundle install --path vendor/bundle --binstubs
