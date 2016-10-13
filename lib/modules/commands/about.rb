module Bot
  module DiscordCommands
    # Basic info about bot.
    # No comment needed.
    module About
      extend Discordrb::Commands::CommandContainer
      command :about do |event|
        event << "Hello! I'm glue-bot."
        event << "I have some cool commands, just type `#{BOT.prefix}help` for more;)"
        event << "I'm created by #{event.bot.user(127_405_523_598_311_424).name}"
        event << 'using discordrb (Ruby), :clock2: and :heart:'
      end
    end
  end
end
