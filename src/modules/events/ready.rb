# frozen_string_literal: true

module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.game = CONFIG.game
        puts BOT.invite_url
        puts "Bot is ready! #{Time.now}"
      end
    end
  end
end
