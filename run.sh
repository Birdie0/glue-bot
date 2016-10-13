while true
do
  # uncomment this if you want use updating from github.com when launch or restart bot
  # echo "updating from git.."
  # git pull

  # uncomment this if you want use style checker when launch or restart bot
  # echo "running rubocop.."
  # rubocop lib

  # uncomment this if you want use generating documentation when launch or restart bot
  # echo "updating documentation.."
  # yardoc lib

  echo "starting bot.."
  ruby run.rb
done