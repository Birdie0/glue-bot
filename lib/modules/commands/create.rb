module Bot
  module DiscordCommands
    # Creates empty playlist.
    module Create
      extend Discordrb::Commands::CommandContainer
      command(:create, max_args: 1, bucket: :limit, permission_level: 1) do |event, file|
        if File.exist?("playlists/#{file.downcase}.txt")
          event << "#{file} playlist already exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          File.open("playlists/#{file.downcase}.txt", 'w') {}
        end
        nil
      end
    end
  end
end
