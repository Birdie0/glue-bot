# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Command for evaluating Ruby code in an active bot.
    # Only the `event.user` with matching discord ID of `CONFIG.owner`
    # can use this command.
    module Eval
      extend Discordrb::Commands::CommandContainer
      command(:eval, help_available: false) do |event, *code|
        break unless event.user.id == CONFIG.owner_id
        begin
          eval code.join(' ')
        rescue StandardError => e
          event.send_temp("```#{e}```", 15)
        end
      end
      command(:eval2, help_available: false) do |event|
        break unless event.user.id == CONFIG.owner_id
        code = event.message.content.match(/```(rb|ruby)\n(?<code>(\n|.)*)```/)['code']
        begin
          eval code
        rescue StandardError => e
          event.send_temp("```#{e}```" + "```#{e.backtrace.join('\n')}```", 15)
        end
      end
    end
  end
end
