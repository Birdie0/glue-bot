# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Command for evaluating Ruby code in an active bot.
    # Only the `event.user` with matching discord ID of `CONFIG.owner`
    # can use this command.
    module Ifttt
      extend Discordrb::Commands::CommandContainer
      command(:jbeauty, help_available: false) do |event|
        body = event.message.content.match(/```json\n(?<body>(\n|.)*)```/)
        if body['body']
          begin
            event << "```json\n#{MultiJson.dump(MultiJson.load(body), pretty: true)}```"
          rescue MultiJson::ParseError => e
            match = e.cause.to_s.match(/line (?<line>\d+), column (?<column>\d+)/)
            reason = e.data.to_s.split("\n").insert(match['line'].to_i, '^'.rjust(match['column'].to_i, ' ')).join("\n")
            event << "```rb\n#{reason}``````rb\n#{e.cause}```"
          end
        else
          event << "Make sure you put json body between \`\`\`json \`\`\`"
        end
      end
    end
  end
end
