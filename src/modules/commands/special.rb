# frozen_string_literal: true

module Bot
  module DiscordCommands
    #  some things
    module Special
      extend Discordrb::Commands::CommandContainer
      # mee6 shard calculation
      command(:mshard) do |event, id = event.server.id.to_s|
        event.channel.send_embed do |embed|
          embed.title = "Mee6's shard. Server id:#{id}"
          embed.description = "#{(id.to_i >> 22) % 256}/256"
          color = embed.color = rand(0..0xFFFFFF)
          embed.color = color
        end
      end
      # shibe command
      command(:shibe) do |event|
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTParty.get('http://shibe.online/api/shibes?count=1').parsed_response[0])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'random shibe from shibe.online')
          embed.color = rand(0..0xFFFFFF)
        end
      end
      # bird command
      command(:cat) do |event|
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTParty.get('http://shibe.online/api/cats?count=1').parsed_response[0])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'random cat from shibe.online')
          embed.color = rand(0..0xFFFFFF)
        end
      end
      # bird command
      command(:bird) do |event|
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTParty.get('http://shibe.online/api/birds?count=1').parsed_response[0])
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'random bird from shibe.online')
          embed.color = rand(0..0xFFFFFF)
        end
      end
      # mee6 leaderboard command
      command(:meelead) do |event|
        server_id = event.server.id
        link = "https://mee6.xyz/levels/#{server_id}?json=1&limit=10"
        response = HTTParty.get(link).parsed_response['players']
        parsed = response.map do |i|
          {
            name_text: "#{i['name']} (Level #{i['lvl']})",
            level_text: "#{i['xp']}/#{i['lvl_xp']} (#{i['xp_percent']}%)\nT: #{i['total_xp']} xp\nMin:#{((i['lvl_xp'] - i['xp']) / 25.0).ceil} Max:#{((i['lvl_xp'] - i['xp']) / 15.0).ceil} Avg:#{((i['lvl_xp'] - i['xp']) / 20.0).ceil}"
          }
        end
        event.channel.send_embed('') do |embed|
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: 'Mee6 Leaderboard',
            url: "https://mee6.xyz/levels/#{server_id}",
            icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
          )
          parsed.each do |j|
            embed.add_field(
              name: j[:name_text],
              value: j[:level_text],
              inline: true
            )
          end
          embed.colour = rand(0..0xffffff)
        end
      end
    end
  end
end
