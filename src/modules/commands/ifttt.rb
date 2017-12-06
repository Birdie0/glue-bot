# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Command for evaluating Ruby code in an active bot.
    # Only the `event.user` with matching discord ID of `CONFIG.owner`
    # can use this command.
    module Ifttt
      extend Discordrb::Commands::CommandContainer

      # json beautify
      command(:jbeauty) do |event|
        body = event.message.content.match(/```.*\n(?<body>(\n|.)*)```/)
        if body
          begin
            event << "```json\n#{MultiJson.dump(MultiJson.load(body['body']), pretty: true)}```"
          rescue MultiJson::ParseError => e
            match = e.cause.to_s.match(/line (?<line>\d+), column (?<column>\d+)/)
            reason = e.data.to_s.split("\n").insert(match['line'].to_i, '^'.rjust(match['column'].to_i, '_')).slice(match['line'].to_i - 3 > 0 ? match['line'].to_i - 3 : 0, 6).join("\n")
            event << "```rb\n#{reason}``````fix\n#{e.cause}```"
          end
        else
          event << 'Make sure you put json body between \\`\\`\\` \\`\\`\\`'
        end
      end

      # set key
      command(:setkey, min_args: 1) do |event, key|
        if REDIS.set("maker_key:#{event.user.id}", key) == 'OK'
          event << 'Key has been saved! Now you can send requests to IFTTT webhooks service using `send` command.'
          event << 'If you want to remove key send `delkey` command to remove your key from storage.'
        else
          event << 'Something went wrong!'
        end
      end

      # delete key
      command(:delkey) do |event|
        REDIS.del("maker_key:#{event.user.id}")
        event << 'Done!'
      end

      # set webhook url
      command(:seturl, min_args: 1) do |event, url|
        if url =~ %r{https:\/\/((canary|ptb).)?discordapp\.com\/api\/webhooks\/\d+\/[0-9a-zA-Z\-_]+} && (HTTParty.get(url).code == 200)
          if REDIS.set("webhook_url:#{event.user.id}", url) == 'OK'
            event << 'Webhook url has been saved! Now you can send webhook requests using `webhook` command.'
            event << 'If you want to remove key send `delurl` command to remove your key from storage.'
          else
            event << 'Something went wrong!'
          end
        else
          event << 'Invalid webhook url!'
        end
      end

      # delete webhook url
      command(:delurl) do |event|
        REDIS.del("webhook_url:#{event.user.id}")
        event << 'Done!'
      end

      command(:send, min_args: 1, description: 'sends request on `event` with variables separated by pipes `|`',
                     usage: "#{CONFIG.prefix}send <event> [[value1]|[value2]|[value3]]") do |event, event_name, *options|
        maker_key = REDIS.get "maker_key:#{event.user.id}"
        if maker_key
          if event_name =~ /[A-Za-z\-_]+/
            options = options.join(' ').split('|')
            params = { value1: options[0], value2: options[1], value3: options[2] }
            response = HTTParty.post("https://maker.ifttt.com/trigger/#{event_name}/with/key/#{maker_key}", body: params)
            event.channel.send_embed do |embed|
              if response.code == 200
                embed.color = 0x1ad413
                embed.title = 'Success!'
              else
                embed.color = 0xf51e1e
                embed.title = 'Whoops, something went wrong!'
              end
            end
          else
            event << 'Invalid event name.'
            event << 'Good: `test`, `click`, `tweet_test`'
            event << 'Bad: `aaa bbb`, `!_aaaa!!!!`'
          end
        else
          event << 'Maker key is missing!'
          event << 'Go to <https://ifttt.com/maker_webhooks> => **Documentation**'
          event << "and add your maker key to bot with `#{event.bot.prefix}setkey <maker_key>` in DM!"
        end
      end

      # desc
      command(:webhook) do |event|
        url = REDIS.get "webhook_url:#{event.user.id}"
        if url
          body = event.message.content.match(/```.*\n(?<body>(\n|.)*)```/)
          if body
            begin
              response = HTTParty.post(url, body: body['body'])
              event.channel.send_embed do |embed|
                if response.code == 204
                  embed.color = 0x1ad413
                  embed.title = 'Success!'
                else
                  embed.color = 0xf51e1e
                  embed.title = 'Whoops, something went wrong!'
                end
              end
            rescue MultiJson::ParseError => e # TODO: make output smaller
              match = e.cause.to_s.match(/line (?<line>\d+), column (?<column>\d+)/)
              reason = e.data.to_s.split("\n").insert(match['line'].to_i, '^'.rjust(match['column'].to_i, ' ')).join("\n")
              event << "```rb\n#{reason}``````fix\n#{e.cause}```"
            end
          else
            event << 'Make sure you put json body between \\`\\`\\` \\`\\`\\`'
          end
        else
          event << 'Webhook url is missing!'
          event << "Send me it using `#{event.bot.prefix}seturl <webhook_url>` command in DM!"
        end
      end

    end
  end
end
