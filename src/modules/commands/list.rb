module Bot
  module DiscordCommands
    # Show list of pre-generated playlists.
    module List
      extend Discordrb::Commands::CommandContainer
      command :list do |event|
        event << '```diff'
        event << 'Available playlists:'
        Dir.glob('playlists/*.txt').each do |i|
          event << "+#{File.basename(i, '.txt')}"
        end
        event << '-P.S. You can add your own tracks to **custom** playlist.'
        event << "-Just type `#{BOT.prefix}custom <link or song name>`"
        event << '```'
      end
    end
  end
end
