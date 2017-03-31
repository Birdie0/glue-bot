module Bot
  module DiscordCommands
    # Current *playing now* from `Monstercat.FM`.
    module MCNow
      extend Discordrb::Commands::CommandContainer
      command(:mcnow,
              description: 'Shows information of the currently playing song on Monstercat FM',
              usage: "#{BOT.prefix}mcnow") do |event|
        page = Nokogiri::HTML(open('https://www.mctl.gq/', ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
        event.channel.send_embed do |embed|
          embed.title = 'Monstercat FM'
          embed.description = "*#{page.css('span#title').text} - #{page.css('span#artists').text}*"
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: page.css('img#np-image')[0]['src'])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Album: #{page.css('span#album').text}")
          embed.timestamp = Time.now
          embed.color = [0x399820, 0x1C5A71, 0xB57126, 0xAD2535].sample
        end
      end
    end
  end
end
