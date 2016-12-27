module Bot
  module DiscordCommands
    # Creates empty playlist.
    module Create
      extend Discordrb::Commands::CommandContainer
      command(:create, max_args: 1, bucket: :limit) do |event, file|
        if File.exist?("playlists/#{file.downcase}.txt")
          event << "#{file} playlist already exists!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          File.open("playlists/#{file.downcase}.txt", 'w') {}
          event << "***#{file}*** playlist was created!"
        end
        nil
      end
    end
  end
end
