# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Basic info about bot.
    module Fortune
      extend Discordrb::Commands::CommandContainer

      command(:fortune,
              description: 'Info about the bot',
              usage: "#{BOT.prefix}about") do |event, category|
        cookie = fortune(category)
        event.channel.send_embed('') do |embed|
          embed.title = "Here's your cookie! <:fortunecookie:362519486278008832>"
          embed.description = cookie['text']
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Lucky numbers: #{cookie['lucky_numbers']}")
        end
      end

    end
  end
end
