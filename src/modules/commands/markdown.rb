# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Sends picture with easy-to-learn Markdown basics.
    module Markdown
      extend Discordrb::Commands::CommandContainer

      command(:markdown,
              description: 'Little tutorial of Discord Markdown',
              usage: "#{BOT.prefix}markdown") do |event|
        event.channel.send_file File.new('pictures/markdown.png')
      end

    end
  end
end
