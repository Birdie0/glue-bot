# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Some commands written for Mee6
    module Mee6
      extend Discordrb::Commands::CommandContainer

      # mee6 shard calculation
      command(:mshard) do |event, id = event.server.id|
        n = 320 # number of shards
        @servers ||= []
        table = if @servers.empty?
                  'placeholder'
                else
                  "```#{@servers.join("\n")}```"
                end
        event.channel.send_embed do |embed|
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: "Mee6's shard. Server id: #{id}",
            url: 'https://mee6.xyz/',
            icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
          )
          embed.description = "#{(id.to_i >> 22) % n}/#{n}"
          embed.color = rand(0..0xFFFFFF)
          embed.add_field(
            name: 'Last 5 shard checks',
            value: table
          )
          @servers = @servers.push("#{((id.to_i >> 22) % n).to_s.rjust(3, ' ')} | #{id}").last(5)
        end
      end

      # mee6 leaderboard command
      command(:meelead) do |event|
        server_id = event.server.id
        link = "https://mee6.xyz/levels/#{server_id}?json=1"
        response = HTTParty.get(link).parsed_response['players']
        parsed = response.map do |i|
          {
            name_text: "#{i['name']} (Level #{i['lvl']})",
            level_text: "#{i['xp']}/#{i['lvl_xp']} (#{i['xp_percent']}%)\nT: #{i['total_xp']} xp\nMin:#{((i['lvl_xp'] - i['xp']) / 25.0).ceil} Avg:#{((i['lvl_xp'] - i['xp']) / 20.0).ceil} Max:#{((i['lvl_xp'] - i['xp']) / 15.0).ceil}"
          }
        end
        event.channel.send_embed('') do |embed|
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: 'Mee6 Leaderboard',
            url: "https://mee6.xyz/levels/#{server_id}",
            icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
          )
          parsed.first(12).each do |j|
            embed.add_field(
              name: j[:name_text],
              value: j[:level_text],
              inline: true
            )
          end
          embed.colour = rand(0..0xffffff)
        end
      end

      # mee6 leaderboard command
      command(:meeroles) do |event|
        server_id = event.server.id
        link = "https://mee6.xyz/levels/#{server_id}?json=1&limit=0"
        response = HTTParty.get(link).parsed_response['reward_roles']
        response = response.sort_by { |key, _value| key.to_i }
        description = []
        response.map do |i, j|
          description << "**Level #{i}**"
          j.map do |k|
            description << "  #{k['name']} <@&#{k['id']}>"
          end
        end
        event.channel.send_embed('') do |embed|
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: 'Mee6 Role Rewards',
            url: "https://mee6.xyz/levels/#{server_id}",
            icon_url: 'https://cdn.discordapp.com/emojis/230231424739835904.png'
          )
          embed.description = description.join("\n")
          embed.colour = rand(0..0xffffff)
        end
      end

      command(:ask) do |event, *question|
        response = QNA.generate_answer(question.join(' '))
        event << "#{response.answer} [#{response.score}]"
      end

      # command(:addq, required_roles: [193_123_929_701_875_712]) do |event|
      #   match = event.message.content.match(/q: (?<question>(.+))\na: (?<answer>(.|\n)+)/)
      #   if match && match['question'] && match['answer']
      #     QNA.update_kb([answer: match['answer'], question: match['question']])
      #   else
      #     event << "nope! try something like: ```\nq: why something something?\n a: because that!```"
      #   end
      # end

      # command(:train, required_roles: [193_123_929_701_875_712]) do |event|
      #   match = event.message.content.match(/u: (?<question2>(.+))\nq: (?<question>(.+))\na: (?<answer>(.|\n)+)/)
      #   if match && match['question2'] && match['question'] && match['answer']
      #     QNA.train_kb(match['question2'], match['question'], match['answer'])
      #   else
      #     event << "nope! try something like: ```\nu: why?\nq: why something something?\n a: because that!```"
      #   end
      # end

      # command(:update, required_roles: [193_123_929_701_875_712]) do |event|
      #   event << QNA.publish_kb
      # end
    end
  end
end
