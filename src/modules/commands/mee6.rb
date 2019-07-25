# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Some commands written for Mee6
    module Mee6
      extend Discordrb::Commands::CommandContainer

      REDIS.setnx('mee6_shards', 512)

      # mee6 shard calculation
      command(:mshard) do |event, id = event.server.id|
        n = REDIS.get('mee6_shards').to_i # number of shards
        @servers ||= []
        table = if @servers.empty?
                  'placeholder'
                else
                  "```\n#{@servers.join("\n")}```"
                end
        event.channel.send_embed do |embed|
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: "Mee6's shard. Server id: #{id}",
            url: 'https://mee6.xyz/',
            icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
          )
          embed.description = "#{(id.to_i >> 22) % n}/#{n}"
          embed.color = rand(0..0xffffff)
          embed.add_field(
            name: 'Last 5 shard checks',
            value: table
          )
          @servers = @servers.push("#{((id.to_i >> 22) % n).to_s.rjust(3, ' ')} | #{id}").last(5)
        end
      end

      # mee6 leaderboard command
      command(:meelead) do |event, server_id| # fix xp/min/avg/max fields
        server_id ||= event.server.id
        response = HTTP.get("https://mee6.xyz/api/plugins/levels/leaderboard/#{server_id}?limit=12")
        if response.code == 200
          event.channel.send_embed do |embed|
            embed.color = rand(0..0xffffff)
            embed.author = Discordrb::Webhooks::EmbedAuthor.new(
              name: 'Mee6 Leaderboard',
              url: "https://mee6.xyz/levels/#{server_id}",
              icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
            )
            response.parse['players'].each_with_index do |player, index|
              user = get_xp_info(player)
              embed.add_field(
                name: "#{index + 1}) #{user.name} (Level: #{user.level})",
                value: "#{user.xp}/#{user.level_xp_max} (#{user.percent}%)\n" \
                       "T:#{user.total_xp}xp\n" \
                       "Min:#{((user.level_xp_max - user.remaining) / 25.0).ceil} " \
                       "Avg:#{((user.level_xp_max - user.remaining) / 20.0).ceil} " \
                       "Max:#{((user.level_xp_max - user.remaining) / 15.0).ceil}",
                inline: true
              )
            end
          end
        else
          event << 'Server not found!'
        end
      end

      # mee6 leaderboard command alternate
      command(:meelead2) do |event, server_id|
        server_id ||= event.server.id
        response = HTTP.get("https://mee6.xyz/api/plugins/levels/leaderboard/#{server_id}?limit=12")
        if response.code == 200
          table = TTY::Table.new header: ['#', 'Username', 'Level', '%', 'Total', 'Min', 'Avg', 'Max']
          response.parse['players'].each_with_index do |player, index|
            user = get_xp_info(player)
            table << [index + 1,
                      user.name,
                      user.level,
                      user.percent,
                      user.total_xp,
                      ((user.level_xp_max - user.remaining) / 25.0).ceil,
                      ((user.level_xp_max - user.remaining) / 20.0).ceil,
                      ((user.level_xp_max - user.remaining) / 15.0).ceil]
          end
          "```\n#{table.render(:unicode, alignment: [:center])}```"
        else
          event << 'Server not found!'
        end
      end

      # # mee6 roles command
      # command(:meeroles) do |event|
      #   server_id = event.server.id
      #   link = "https://mee6.xyz/levels/#{server_id}?json=1&limit=0"
      #   response = HTTP.get(link).parse['reward_roles']
      #   response = response.sort_by { |key, _value| key.to_i }
      #   description = []
      #   response.map do |i, j|
      #     description << "**Level #{i}**"
      #     j.map do |k|
      #       description << "  #{k['name']} <@&#{k['id']}>"
      #     end
      #   end
      #   event.channel.send_embed do |embed|
      #     embed.author = Discordrb::Webhooks::EmbedAuthor.new(
      #       name: 'Mee6 Role Rewards',
      #       url: "https://mee6.xyz/levels/#{server_id}",
      #       icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
      #     )
      #     embed.description = description.join("\n")
      #     embed.colour = rand(0..0xffffff)
      #   end
      # end

      command(:ask) do |event, *question|
        response = QNA.generate_answer(question.join(' '))
        event << "#{response.first.answer} [#{response.first.score}]"
      end

    end
  end
end
