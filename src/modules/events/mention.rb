module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module Mention
      extend Discordrb::EventContainer
      mention(contains: "prefix") do |event|
        event << "Oh, wow! Do You wanna know my prefix?"
        event << "It's `#{CONFIG.prefix}`, silly... :wink:"
      end
    end
  end
end
