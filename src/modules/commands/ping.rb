# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Responds with "Pong!".
    # This used to check if bot is alive
    module Ping
      extend Discordrb::Commands::CommandContainer

      command(:ping,
              description: 'Sends pong message with ping delay.',
              usage: "#{BOT.prefix}ping") do |event|
        m = event.respond 'Pong!'
        m.edit "Pong! `#{((Time.now - event.timestamp) * 1000).round(3)} ms`"
      end

    end
  end
end
