# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Sends random comic from xkcd.com.
    module Xkcd
      extend Discordrb::Commands::CommandContainer

      command(:xkcd,
              description: 'Sends a random comic from <https://xkcd.com>',
              usage: "#{BOT.prefix}xkcd") do |event|
        site = HTTP.follow.get('https://c.xkcd.com/random/comic/')
        page = Nokogiri::HTML(site.to_s)
        event.channel.send_embed do |embed|
          embed.title = "XKCD - #{page.css('div#ctitle').text}"
          embed.url = site.uri.to_s
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https:' + page.css('div#comic img')[0]['src'])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: page.css('div#comic img')[0]['title'])
          embed.color = [0xb6c114, 0x60c114, 0x14c11f, 0x014c75, 0x14b6c1, 0x1460c1].sample
        end
      end

    end
  end
end
