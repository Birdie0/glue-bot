# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Shows list of playlists.
    module List
      extend Discordrb::Commands::CommandContainer

      command(:list,
              description: 'Shows a list of all existing playlists.',
              usage: "#{BOT.prefix}list") do |event|
        event << '```css'
        event << "📁 C:      [#{BOT.prefix}play <playlist> <prefix> <n>] - plays playlist"
        event << "║          [#{BOT.prefix}show <playlist> <page>] - shows playlist"
        event << '╚═💿 Music'
        event << '   │'
        playlists = Dir['data/playlists/*.json']
        playlists[0...-1].each { |i| event << "   ├─#{File.basename(i, '.json')}.pls" }
        event << "   └─#{File.basename(playlists.last, '.json')}.pls```"
      end

    end
  end
end
