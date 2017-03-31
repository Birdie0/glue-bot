module Bot
  module DiscordCommands
    # Turns off your bot.
    # If you launch bot with `./run.sh` it's will restarts.
    module Restart
      extend Discordrb::Commands::CommandContainer
      command(:restart,
              help_available: false,
              description: 'Restarts and updates bot. Owner command.',
              usage: "#{BOT.prefix}restart") do |event|
        break unless event.user.id == CONFIG.owner
        puts 'Restarting...'
        event.respond ['Restarting', 'Buying more games', 'Making more tea', 'Refreshing playlists', 'Checking friend list'].sample + '...'
        BOT.stop
        exit
      end
    end
  end
end
