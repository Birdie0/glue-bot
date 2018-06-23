# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Shows random comic from a Webcomicname.
    module Ohno
      extend Discordrb::Commands::CommandContainer

      command(:ohno,
              description: 'Sends a random comic from <http://webcomicname.com>',
              usage: "#{BOT.prefix}ohno") do |event|
        site = HTTP.follow.get('http://webcomicname.com/random')
        page = Nokogiri::HTML(site.to_s)
        event.channel.send_embed do |embed|
          embed.title = 'oh no!'
          embed.url = site.uri.to_s
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: page.css('div.photo-wrapper-inner a img').first['src'])
          embed.color = [0xFF7DB6, 0xFFF566, 0x8FFFA7, 0x75B1FF, 0xB67DFF].sample
        end
      end

    end
  end
end
