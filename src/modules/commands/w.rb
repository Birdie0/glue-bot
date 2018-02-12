# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Basic info about bot.
    module W
      extend Discordrb::Commands::CommandContainer

      base_url = 'https://birdie0.github.io/discord-webhooks-guide'
      path = 'tmp/discord-webhooks-guide'

      if Dir.exist?(path)
        g = Git.open(path)
        g.pull
      else
        g = Git.clone(
          'git@github.com:Birdie0/discord-webhooks-guide.git',
          'discord-webhooks-guide',
          path: 'tmp'
        )
      end

      REDIS = Redis.new

      if REDIS.get('guide-timestamp') != g.log.first.date.getutc.to_s
        puts REDIS.get('guide-timestamp')
        puts g.log.first.date.getutc
        x = []
        Dir.glob(path + '/docs/structure/**/*.md') do |file|
          content = File.read(file)
          match = content.match(/# (?<name>\w+)\n\n(?<description>(.|\n)+)\n\nExamples?:\n\n(?<example>```json\n(.|\n)+```)\n\n!.+\.\.(?<image>.+\D\.png)\)/i)
          if match
            x << {
              'name' => match['name'],
              'description' => match['description'],
              'image' => match['image'],
              'example' => match['example']
            }
          else
            puts "fail to parse #{file}"
          end
        end
        File.write('config/webhook.yml', x.to_yaml)
        REDIS.set('guide-timestamp', g.log.first.date.getutc.to_s)
      end

      INFO = YAML.load_file('config/webhook.yml')

      command(:w, help_available: false) do |event, element|
        info = INFO.find { |i| i['name'] == element }
        if info
          event.channel.send_embed do |embed|
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
