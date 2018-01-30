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
          'Picking Yasuo',
          'Taking out the dog',
          'Doing some dank 360 noscopes',
          'Doing some sick AWP flicks',
          'Staring at nothing',
          'Making spaghetti',
          'Hacking Facebook',
          'Picking Moira',
          'Opening loot boxes',
          'Writing my testament',
          'Looking at my husbando',
          'Reading news on Facebook',
          'Posting some lewd photos on Instagram',
          'Ordering some pizza',
          'Rushing B',
          'Clicking circles',
          'Going shopping',
          'Listening to trap songs',
          'Listening to pop songs',
          'Listening to house songs',
          'Picking Dokkaebi',
          'Writing an essay',
          'Calling the domestic violence hotline',
          'Brewing some potions',
          'Sinking into the ocean',
          'Drinking some beer',
          'Yelling at my teammates'
        ].sample + '...')
        BOT.stop
        exit
      end

    end
  end
end
