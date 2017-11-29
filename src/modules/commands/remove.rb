# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Removes song from chosen playlist.
    module Remove
      extend Discordrb::Commands::CommandContainer

      command(:remove,
              min_args: 2,
              description: 'Removes song from the playlist.',
              usage: "#{BOT.prefix}remove <playlist> <song name>") do |event, name, *args|
        name.downcase!
        if !File.exist?("data/playlists/#{name}.json")
          event << "*#{name}* playlist does not exist!"
        else
          hash = JSON.parse(File.read("data/playlists/#{name}.json"))
          if !hash['authors'].include? event.user.id
            event << 'You can\'t edit this playlist.'
          else
            result = hash['songs'].find { |_i, j| j.downcase.include? args.join(' ').downcase }
            event << '```md'
            if result
              hash['songs'].delete result.first
              open("data/playlists/#{name}.json", 'w') { |f| f << JSON.pretty_generate(hash) }
              event << "#{result.last} has been deleted from #{name} playlist..."
              event.bot.channel(CONFIG.channel_id).send "`#{result.last} deleted by #{event.user.name} from #{name} playlist`"
            else
              event << '# No results...'
            end
            event << '```'
          end
        end
        nil
      end

    end
  end
end
