module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module Commands
      extend Discordrb::EventContainer
      message(start_with: CONFIG.prefix) do |event|
        break unless event.message.command
        puts ""
        COMMANDS_USED += 1
      end
    end
  end
end
