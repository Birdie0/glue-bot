# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Creates empty playlist.
    module Create
      extend Discordrb::Commands::CommandContainer

      command(:create,
              max_args: 1,
              description: 'Creates a new playlist',
              usage: "#{BOT.prefix}create <playlist>") do |event, name|
        name.downcase!
        if File.exist?("config/playlists/#{name.downcase}.json")
          event << "#{name} playlist already exists!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          File.write("config/playlists/#{name}.json", JSON.pretty_generate(authors: [event.user.id], songs: {})) # replace with OJ.dump
          event << "*#{name}* playlist was created!"
          BOT.channel(CONFIG.channel_id).send("`#{name} playlist was created by #{event.user.name}`")
        end
        nil
      end

    end
  end
end
