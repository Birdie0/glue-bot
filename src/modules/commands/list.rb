module Bot
  module DiscordCommands
    # Show list of playlists.
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
        Dir['data/playlists/*.json'].each { |i| event << "   ├─#{File.basename(i, '.json')}.pls" }
        event << '   └─backup.zip```'
      end
    end
  end
end
