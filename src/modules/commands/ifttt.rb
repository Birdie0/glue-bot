# frozen_string_literal: true

module Bot
  module DiscordCommands
    # IFTTT related commands
    module Ifttt
      extend Discordrb::Commands::CommandContainer

      # json beautify
      command(:jbeauty) do |event|
        body = event.message.content.match(/```(json)?\n(?<body>(\n|.)*)```/)
        if body
          begin
            event << "```json\n#{JSON.pretty_generate(Oj.load(body['body']))}```" # Replace with Oj.dump
          rescue Oj::ParseError
            # match = e.cause.to_s.match(/line (?<line>\d+), column (?<column>\d+)/)
            # reason = e.data.to_s.split("\n").insert(match['line'].to_i, '^'.rjust(match['column'].to_i, '_'))
            #           .slice(match['line'].to_i - 3 > 0 ? match['line'].to_i - 3 : 0, 6).join("\n")
            # event << "```rb\n#{reason}``````fix\n#{e.cause}```"
            event << 'Invalid JSON body!'
          end
        else
          event << "Put json body between\n\\`\\`\\`json\n \\`\\`\\`"
        end
      end

      # json escape
      command(:jescape) do |event|
        body = event.message.content.match(/```(json)?\n(?<body>(\n|.)*)```/)
        if body
          body = body['body'].gsub('<<<', '')    .gsub('>>>', '')
                             .gsub('{{', '<<<{{').gsub('}}', '}}>>>')
          begin
            event << "```json\n#{JSON.pretty_generate(Oj.load(body))}```" # Replace with Oj.dump
          rescue Oj::ParseError
            # match = e.cause.to_s.match(/line (?<line>\d+), column (?<column>\d+)/)
            # reason = e.data.to_s.split("\n").insert(match['line'].to_i, '^'.rjust(match['column'].to_i, '_'))
            #           .slice(match['line'].to_i - 3 > 0 ? match['line'].to_i - 3 : 0, 6).join("\n")
            # event << "```rb\n#{reason}``````fix\n#{e.cause}```"
            event << 'Invalid JSON body!'
          end
        else
          event << "Put json body between\n\\`\\`\\`json\n \\`\\`\\`"
        end
      end

      # set key
      command(:setkey, min_args: 1) do |event, key|
        if key =~ /[a-zA-Z0-9\-_]+/
          if REDIS.set("maker_key:#{event.user.id}", key) == 'OK'
            event << 'Key has been saved! Now you can send requests to IFTTT webhooks service using `send` command.'
            event << 'If you want to remove key send `delkey` command to remove your key from storage.'
          else
            event << 'Something went wrong!'
          end
        else
          event << 'Usually maker key includes letters, numbers, dashes and underscores only. Try again!'
        end
      end

      # delete key
      command(:delkey) do |event|
        REDIS.del("maker_key:#{event.user.id}")
        event << 'Done!'
      end

      # set webhook url
      command(:seturl, min_args: 1) do |event, url|
        if url =~ %r{https:\/\/((canary|ptb).)?discordapp\.com\/api\/webhooks\/\d+\/[0-9a-zA-Z\-_]+} && (HTTP.get(url).code == 200)
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
          if event_name =~ /[a-z\-_]+/i
            options = options.join(' ').split('|')
            params = { value1: options[0], value2: options[1], value3: options[2] }
            response = HTTP.post("https://maker.ifttt.com/trigger/#{event_name}/with/key/#{maker_key}", json: params)
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
          event << "and add your maker key to bot with `#{BOT.prefix}setkey <maker_key>` in DM!"
        end
      end

      # desc
      command(:webhook) do |event|
        url = REDIS.get "webhook_url:#{event.user.id}"
        if url
          body = event.message.content.match(/```.*\n(?<body>(\n|.)*)```/)
          if body
            begin
              response = HTTP.post(url, json: Oj.load(body['body']))
              event.channel.send_embed do |embed|
                if response.code == 204
                  embed.color = 0x1ad413
                  embed.title = 'Success!'
                else
                  embed.color = 0xf51e1e
                  embed.title = "Whoops, something went wrong! Error:#{response.code}"
                  embed.description = response.to_s
                end
              end
            rescue Oj::ParseError # TODO: make output smaller
              # match = e.cause.to_s.match(/line (?<line>\d+), column (?<column>\d+)/)
              # reason = e.data.to_s.split("\n").insert(match['line'].to_i, '^'.rjust(match['column'].to_i, ' ')).join("\n")
              # event << "```rb\n#{reason}``````fix\n#{e.cause}```"
              event << 'Invalid JSON body!'
            end
          else
            event << "Put json body between\n\\`\\`\\`json\n \\`\\`\\`"
          end
        else
          event << 'Webhook url is missing!'
          event << "Send me it using `#{BOT.prefix}seturl <webhook_url>` command in DM!"
        end
      end

    end
  end
end
