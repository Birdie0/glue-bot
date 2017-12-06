# frozen_string_literal: true

module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to Discord.
    module Ready
      extend Discordrb::EventContainer

      ready do |event|
        event.bot.game = CONFIG.game
        puts BOT.invite_url
        puts "Bot is ready! #{Time.now}"
        event.bot.channel(REDIS.get('last_channel')).send("I'm back!") if REDIS.get('last_channel')
        REDIS.del('last_channel')
      end

    end
  end
end
