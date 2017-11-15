# frozen_string_literal: true

module Bot
  module DiscordCommands
    # Add music request from pre-generated playlists.
    # Max 8 songs for one request.
    ### 13-14 > bucket: :limit
    module Play
      extend Discordrb::Commands::CommandContainer
      command(:play,
              min_args: 1,
              max_args: 3,
              description: 'Adds up to 8 random titles from the playlist. Prefix by default - `!add`. Use underscore `_` if prefix have more than two words in prefix.',
              usage: "#{BOT.prefix}play <playlist> [bot_prefix = !add] [n = 5]") do |event, name, prefix = '!add', n = 5|
        name.downcase!
        if !File.exist?("data/playlists/#{name}.json")
          event << "#{name} playlist doesn't exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          prefix = prefix.tr('_', ' ')
          n = '8' if n.to_i > 8
          event.respond "#{n} songs added by *#{event.user.name}* from #{name} playlist"
          sleep 0.5
          hash = JSON.parse(File.read("data/playlists/#{name}.json"))['songs']
          hash.keys.sample(n.to_i).each do |i|
            event.send_temp("#{prefix} https://youtu.be/#{i}", 1)
            sleep 2
          end
        end
        nil
      end
    end
  end
end
