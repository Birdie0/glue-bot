# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Sends random comic from xkcd.com .
    module Xkcd
      extend Discordrb::Commands::CommandContainer
      command(:xkcd,
              description: 'Sends a random comic from <https://xkcd.com>',
              usage: "#{BOT.prefix}xkcd") do |event|
        page = Nokogiri::HTML(open('https://c.xkcd.com/random/comic/', ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
        event.channel.send_embed do |embed|
          embed.title = "XKCD - #{page.css('div#ctitle').text}"
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https:' + page.css('div#comic img')[0]['src'])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: page.css('div#comic img')[0]['title'])
          embed.color = [0xB6C114, 0x60C114, 0x14C11F, 0x14C75, 0x14B6C1, 0x1460C1].sample
        end
      end
    end
  end
end
