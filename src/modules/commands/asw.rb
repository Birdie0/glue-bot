# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Shows random comic from a Softer World.
    module ASofterWorld
      extend Discordrb::Commands::CommandContainer

      command(:asw,
              description: 'Sends a random comic from <http://www.asofterworld.com>\nAdd number after command if you want to see certain comic.',
              usage: "#{BOT.prefix}asw [n]") do |event, n = rand(1..1248)|
        url = "http://www.asofterworld.com/index.php?id=#{n}"
        page = Nokogiri::HTML(HTTP.get(url).to_s)
        event.channel.send_embed do |embed|
          embed.title = "a Softer World ##{n}"
          embed.url = url
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: page.css('div#comicimg img')[0]['src'])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: page.css('div#comicimg img')[0]['title'])
          embed.color = [0x399820, 0x1c5a71, 0xb57126, 0xad2535].sample
        end
      end

    end
  end
end
