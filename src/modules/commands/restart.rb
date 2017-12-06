# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Sends bot sleep.
    # If you launch bot with `rake runme`, it will restart.
    module Restart
      extend Discordrb::Commands::CommandContainer

      command(:restart,
              help_available: false,
              description: 'Restarts and updates bot. Owner command.',
              usage: "#{BOT.prefix}restart") do |event|
        break unless event.user.id == CONFIG.owner_id
        puts 'Restarting...'
        REDIS.set('last_channel', event.channel.id)
        event.respond([
          'Restarting',
          'Buying more games',
          'Making more tea',
          'Refreshing playlists',
          'Checking friend list'
        ].sample + '...')
        begin
          BOT.stop
        rescue ThreadError
          exit
        end
      end

    end
  end
end
