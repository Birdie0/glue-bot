# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Getting pics from http://platypus.fi/
    module PlatypusOnline
      extend Discordrb::Commands::CommandContainer
      # plat command
      command(:plat, description: 'random picture from <http://platypus.fi/>') do |event, *query|
        base_url = 'http://platypus.fi/backend/'
        params = {
          a: 'images',
          offset: 0,
          number: 1,
          nsfw: 0,
          search: query.join(' '),
          seed: rand(10_000)
        }
        respond = HTTP.get(base_url, params: params).parse(:json)
        case respond['status']
        when 'OK'
          image = respond['images'].first
          # {
          #   "id"=>"1898", "timestamp"=>"2011-12-19 22:22:44",
          #   "filename"=>"img/1324326164_3g79y.jpg", "width"=>"900",
          #   "height"=>"627", "source"=>"http://i.imgur.com/3g79y.jpg",
          #   "tags"=>"caterpillar, macro photography"
          # }
          event.channel.send_embed do |embed|
            embed.author = Discordrb::Webhooks::EmbedAuthor.new(
              name: 'Platypus',
              url: 'http://platypus.fi/',
              icon_url: 'http://platypus.fi/img/ui/share.png'
            )
            embed.description = "[Source](#{image['source']})\nTags: #{image['tags']}"
            embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'http://platypus.fi/' + image['filename'])
            embed.timestamp = Time.parse(image['timestamp'])
            embed.color = rand(0..0xFFFFFF)
          end
        when 'FAIL'
          event << 'Image not found!'
        else
          event << 'Internal error!'
        end
      end
    end
  end
end
