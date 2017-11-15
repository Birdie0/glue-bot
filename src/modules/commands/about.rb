# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Basic info about bot.
    module About
      extend Discordrb::Commands::CommandContainer
      command(:about,
              description: 'Some information about the bot.',
              usage: "#{BOT.prefix}about") do |event|
        event << "Hello! I'm glue-bot."
        event << "I have some cool features, just type `#{BOT.prefix}help` and i will tell you ;)"
        event << "I'm created by #{event.bot.user(127_405_523_598_311_424).name}"
        event << 'using discordrb (Ruby), :clock2: and :heart:'
      end
    end
  end
end
