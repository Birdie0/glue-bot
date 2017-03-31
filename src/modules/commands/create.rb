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
        if File.exist?("data/playlists/#{name.downcase}.json")
          event << "#{name} playlist already exists!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          open("data/playlists/#{name}.json", 'w') { |f| f << JSON.pretty_generate(authors: [event.user.id], songs: {}) }
          event << "*#{name}* playlist was created!"
          event.bot.channel(CONFIG.channel_id).send "`#{name} playlist was created by #{event.user.name}`"
        end
        nil
      end
    end
  end
end
