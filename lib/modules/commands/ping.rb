module Bot
  module DiscordCommands
    # Responds with "Pong!" with ping.
    module Ping
      extend Discordrb::Commands::CommandContainer
      command :ping do |event|
        m = event.respond('Pong!')
        m.edit "Pong! `#{(Time.now - event.timestamp) * 1000} ms`"
      end
    end
  end
end
