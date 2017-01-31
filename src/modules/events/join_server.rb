module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module Join_server
      extend Discordrb::EventContainer
      create_server do |event|
        event.server.owner.pm 'Hello, wierdo! Did you just add me on your server? Pathetic!'
      end
    end
  end
end
