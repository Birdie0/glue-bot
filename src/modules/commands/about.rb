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
        event << 'The reason I was made was doing playlist work for Mee6, but now I can do even more!'
        event << "My prefix is `#{event.bot.prefix}` and my help command is `#{event.bot.prefix}help`"
        event << "I was created by #{event.bot.user(127_405_523_598_311_424).name}"
        event << 'using discordrb <:ruby_taco:336115106670968833>, :clock2: and :heart:'
      end

    end
  end
end
