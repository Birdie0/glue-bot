# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Add song to chosen playlist.
    module Add
      extend Discordrb::Commands::CommandContainer

      command(:add,
              min_args: 2,
              description: 'Adds the song to the playlist.',
              usage: "#{BOT.prefix}addto <playlist> <song name>") do |event, name, *args|
        name.downcase!
        if File.exist?("config/playlists/#{name}.json")
          hash = JSON.parse(File.read("config/playlists/#{name}.json"))
          if !((hash['authors'].include? event.user.id) || (hash['authors'].include? 0))
            event << "You can't edit this playlist."
          else
            video = VIDS.where(q: args.join(' '), order: 'relevance', maxResults: 1).first
            if video
              if hash['songs'].include? video.id
                event << 'That song already exists in the playlist!'
              else
                hash['songs'][video.id] = video.title
                open("config/playlists/#{name}.json", 'w') { |f| f << JSON.pretty_generate(hash) }
                event << "**#{video.title}** has been added to **#{name}** playlist!"
                event.bot.channel(CONFIG.channel_id).send "`#{video.title} added by #{event.user.name} to #{name} playlist`"
              end
            else
              event << 'Video not found!'
            end
          end
        else
          event << "**#{name}** playlist does not exist!"
        end
      end

    end
  end
end
