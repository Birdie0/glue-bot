# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Sends bot to sleep.
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
          'Checking friend list',
          'Taking out the dog',
          'Doing some dank 360 noscopes',
          'Doing some sick AWP flicks',
          'Staring at nothing',
          'Making spaghetti',
          'Hacking Facebook',
          'Looking at my husbando',
          'Reading news on Facebook',
          'Ordering some pizza',
          'Rushing B',
          'Clicking circles',
          'Going shopping',
          'Listening to pop songs',
          'Listening to house songs',
          'Writing an essay',
          'Brewing some potions',
          'Yelling at my teammates',
          'Punching wood',
          'Hacking Minecraft',
          'Paying bills',
          'Updating to Windows 10',
          'Reading a book',
          'Reading Reddit comments'
        ].sample + '...')
        BOT.stop
        exit
      end

    end
  end
end
