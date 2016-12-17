module Bot
  list = ["Crashed... joke ;)", "bye, senpai", "updating...", "adding new commands...", "parsing playlists...", "buying new games...", "updating from git..."]
  module DiscordCommands
    # Turns off your bot.
    # If you launch bot with `./run.sh` it's will restarts.
    module Restart
      extend Discordrb::Commands::CommandContainer
      command(:restart, help_available: false) do |event|
        break unless event.user.id == CONFIG.owner
        event.respond list.sample
        puts "Restart... #{Time.now}"
        exit
      end
    end
  end
end
