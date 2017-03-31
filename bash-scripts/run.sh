while true
do
  echo "updating from git.."
  git pull

  echo "updating gems.."
  bundle install
  
  echo "starting bot.."
  ruby run.rb
done