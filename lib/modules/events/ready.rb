module Bot
  module DiscordEvents
    # This event is processed when the bot connects to Discord.
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.game = CONFIG.game
        puts 'Bot is ready!'
      end
    end
  end
end
