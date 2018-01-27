# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Shows current *playing now* song on `Monstercat.FM`.
    module MCNow
      extend Discordrb::Commands::CommandContainer

      command(:mcnow,
              description: 'Shows information of the currently playing song on Monstercat FM',
              usage: "#{BOT.prefix}mcnow") do |event|
        url = 'https://mctl.io/'
        page = Nokogiri::HTML(open(url))
        event.channel.send_embed do |embed|
          embed.title = 'Monstercat FM'
          embed.url = url
          embed.description = "*#{page.css('span#title').text} - #{page.css('span#artists').text}*"
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: page.css('img#np-image')[0]['src'])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Album: #{page.css('span#album').text}")
          embed.timestamp = Time.now
          embed.color = rand(0..0xFFFFFF)
        end
      end

    end
  end
end
