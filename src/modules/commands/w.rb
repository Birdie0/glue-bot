# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Basic info about bot.
    module W
      extend Discordrb::Commands::CommandContainer

      base_url = 'https://birdie0.github.io/discord-webhooks-guide'
      INFO = YAML.load_file('files/webhook.yml')

      command(:w, help_available: false) do |event, element|
        info = INFO.find { |i| i['name'] == element }
        if info
          event.channel.send_embed('') do |embed|
            embed.title = info['name']
            # embed.url = base_url + '/structure/' + info['link'] + '.html'
            embed.description = info['description']
            embed.add_field(
              name: 'Example',
              value: info['example']
            )
            embed.image = Discordrb::Webhooks::EmbedImage.new(
              url: base_url + info['image']
            )
            embed.color = 0x00897b
          end
        end
        nil
      end

    end
  end
end
