module Bot
  module DiscordCommands
    # Turn off your bot
    # If you launch bot in loop it's restart.
    module Restart
      extend Discordrb::Commands::CommandContainer
      command(:restart, help_available: false) do |event|
        break unless event.user.id == CONFIG.owner
        event.respond 'Okay... :cry: :gun:'
        puts 'Restart...'
        exit
      end
    end
  end
end
