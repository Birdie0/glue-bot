module Bot
  module DiscordCommands
    # Turns off your bot.
    # If you launch bot with `./run.sh` it's will restarts.
    module Restart
      extend Discordrb::Commands::CommandContainer
      command(:restart, help_available: false) do |event|
        break unless event.user.id == CONFIG.owner
        list = ["Crashed... joke ;)", "bye, senpai", "updating...", "adding new commands...", "parsing playlists...", "buying new games...", "updating from git..."]
        event.respond list.sample
        puts "Restart..."
        exit
      end
    end
  end
end
