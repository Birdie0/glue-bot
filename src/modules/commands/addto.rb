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
        if File.exist?("data/playlists/#{name}.json")
          hash = JSON.parse(File.read("data/playlists/#{name}.json"))
          if !((hash['authors'].include? event.user.id) || (hash['authors'].include? 0))
            event << 'You can\'t edit this playlist.'
          else
            YT_CLIENT.search(max_results: 1, query: args.join(' ')) do |v|
              id = v['id']
              title = v['snippet']['title']
              if hash['songs'].include? id
                event << 'That song already exists in the playlist!'
              else
                hash['songs'][id] = title
                open("data/playlists/#{name}.json", 'w') { |f| f << JSON.pretty_generate(hash) }
                event << "*#{title}* was added to #{name} playlist!"
                event.bot.channel(CONFIG.channel_id).send "`#{title} added by #{event.user.name} to #{name} playlist`"
              end
            end
          end
        else
          event << "*#{name}* playlist is not exist!"
        end
        nil
      end

    end
  end
end
