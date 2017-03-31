# installing imagemagick
sudo apt-get update
sudo apt-get install imagemagick -y

# installing bundler
gem install bundler

# installing gems into vendor dir
bundle install --path vendor/bundle --binstubs
