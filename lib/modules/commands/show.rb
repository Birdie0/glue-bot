module Bot
  module DiscordCommands
    # Show music names from pre-generated playlists.
    # Max 10 songs.
    module Show
      extend Discordrb::Commands::CommandContainer
      command(:show, min_args: 1) do |event, file, n = 8|
        if !File.exist?("playlists/#{file.downcase}.txt")
          event << "#{file} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          n = '10' if n.to_i > 10
          sleep 0.5
          event << '```diff'
          event << "Some random songs from #{file.downcase} playlist:"
          File.readlines("playlists/#{file.downcase}.txt").sample(n.to_i).each do |i|
            event << "+#{i.chomp}"
          end
          event << '```'
        end
        nil
      end
    end
  end
end
