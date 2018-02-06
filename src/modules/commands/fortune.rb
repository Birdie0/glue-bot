# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Fortune command
    module Fortune
      extend Discordrb::Commands::CommandContainer

      command(:fortune,
              description: 'gives you fortune cookie',
              usage: "#{BOT.prefix}fortune [category]") do |event, category|
        cookie = fortune(category)
        event.channel.send_embed('') do |embed|
          embed.color = 0xCC9933
          embed.title = "Here's your cookie! <:fortunecookie:362519486278008832>"
          embed.description = cookie['text']
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Lucky numbers: #{cookie['lucky_numbers']}")
        end
      end

    end
  end
end
