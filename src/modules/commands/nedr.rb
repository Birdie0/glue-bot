# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Shows random comic from Nedroid.
    module Nedroid
      extend Discordrb::Commands::CommandContainer

      command(:nedr,
              description: 'Sends a random comic from <http://nedroid.com>',
              usage: "#{BOT.prefix}nedr") do |event|
        site = open('http://nedroid.com/?randomcomic=1')
        page = Nokogiri::HTML(site)
        event.channel.send_embed do |embed|
          embed.title = "Nedroid - **#{page.css('div#comic img')[0]['title']}**"
          embed.url = site.base_uri
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: page.css('div#comic img')[0]['src'])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: page.css('div#comic img')[0]['alt']) if page.css('div#comic img')[0]['title'] != page.css('div#comic img')[0]['alt']
          embed.color = [0xb6c114, 0x60c114, 0x14c11f, 0x14c175, 0x14b6c1, 0x1460c1].sample
        end
      end

    end
  end
end
