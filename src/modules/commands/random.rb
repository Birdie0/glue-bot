# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Picks random n songs from pre-generated playlists.
    # Max 25 songs for one request.
    module Random
      extend Discordrb::Commands::CommandContainer

      command(:random,
              min_args: 2,
              description: 'Picks random n songs from pre-generated playlists.',
              usage: "#{BOT.prefix}rand <playlist> [n = 15]") do |event, name, n = 15|
        name.downcase!
        if !File.exist?("config/playlists/#{name}.json")
          event << "#{name} playlist doesn't exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          n = '25' if n.to_i > 25
          event << "```md"
          event << "Here's your random #{n} songs from #{name} playlist"
          hash = Oj.load_file("config/playlists/#{name}.json")['songs']
          hash.values.sample(n.to_i).each do |i|
            event << "#{i}"
          end
          event << "```"
        end
        nil
      end

    end
  end
end
