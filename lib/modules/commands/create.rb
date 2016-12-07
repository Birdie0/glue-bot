module Bot
  module DiscordCommands
    # Add music request from pre-generated playlists.
    # Max 5 songs for one request.
    module Create
      extend Discordrb::Commands::CommandContainer
      command(:create, max_args: 1, bucket: :limit) do |event, file|
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
