module Bot
  module DiscordCommands
    # Turns off your bot.
    # If you launch bot with `./run.sh` it's will restarts.
    module Restart
      extend Discordrb::Commands::CommandContainer
      command(:restart, help_available: false) do |event|
        break unless event.user.id == CONFIG.owner
        puts 'Restart...'
        event.respond 'Restart...'
        BOT.stop
        exit
      end
    end
  end
end
