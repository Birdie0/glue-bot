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
        page = Nokogiri::HTML(HTTP.get(url).to_s)
        event.channel.send_embed do |embed|
          embed.title = 'Monstercat FM'
          embed.url = url
          embed.description = "*#{page.css('span#title').text} - #{page.css('span#artists').text}*"
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: page.css('img#np-image')[0]['src'])
          embed.add_field(name: 'Spotify link <:spotify:410454519550312448>', value: "[Click here!](#{page.css('span#link').text})")
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Album: #{page.css('span#album').text}")
          embed.timestamp = Time.now
          embed.color = rand(0..0xffffff)
        end
      end

    end
  end
end
