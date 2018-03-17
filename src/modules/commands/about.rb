# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Basic info about bot.
    module About
      extend Discordrb::Commands::CommandContainer

      command(:about,
              description: 'Info about the bot',
              usage: "#{BOT.prefix}about") do |event|
        event << "Hello! I'm glue-bot."
        event << 'My main purpose was doing playlist work for Mee6, but now I can do even more!'
        event << "My prefix is `#{BOT.prefix}` and my help command is `#{BOT.prefix}help`"
        event << "Created by #{BOT.user(127_405_523_598_311_424).distinct}"
        event << 'using discordrb <:ruby_taco:336115106670968833>, :clock2: and :heart:'
        event << 'Source code: <https://git.io/vNMoQ>'
      end

    end
  end
end
