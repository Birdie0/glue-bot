# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Command for evaluating Ruby code in an active bot.
    # Only the `event.user` with matching discord ID of `CONFIG.owner`
    # can use this command.
    module Eval
      extend Discordrb::Commands::CommandContainer

      # eval command
      command(:eval, help_available: false) do |event, *code|
        break unless event.user.id == CONFIG.owner_id
        codebox = event.message.content.match(/```(rb|ruby)?\n(?<code>(.|\n)*)```/)
        begin
          if codebox
            "```rb\n#{eval codebox['code']}```"
          else
            "```rb\n#{eval code.join(' ')}```"
          end
        rescue StandardError => e
          event.send_temp("```#{e}```" + "```#{e.backtrace.join("\n")}```", 15)
        end
      end

    end
  end
end
