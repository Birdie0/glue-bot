# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Fun commands.
    module Fun
      extend Discordrb::Commands::CommandContainer

      command(:order,
              description: 'Info about the bot',
              usage: "#{BOT.prefix}order coffee") do |event, *args|
        name = args.join(' ')
        case name
        when 'coffee', 'tea'
          event.send ':ok_hand: One minute, please!'
          SCHEDULER.in '60s' do
            event.send "#{event.user.mention}, here's your #{name}! :#{name}:"
          end
          nil
        else
          event << 'Sorry, I do not know what is that.'
          event << "Use `#{BOT.prefix}suggest` to send your suggestion. :wink:"
        end
      end

      command(:suggest,
              description: "Send suggestions to bot's dev",
              usage: "#{BOT.prefix}suggest cat command",
              min_args: 1) do |event, *args|
        text = args.join(' ')
        BOT.channel(CONFIG.suggestions_channel_id).send_embed do |embed|
          embed.color = rand(0..0xffffff)
          embed.title = 'New suggestion'
          embed.description = text
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: event.user.name,
            icon_url: event.user.avatar_url
          )
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "ID: #{event.user.id}"
          )
          embed.timestamp = Time.now
        end
        event << 'Suggestion sent! Thanks :cookie:'
      end

    end
  end
end
