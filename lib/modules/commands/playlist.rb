module Bot
  module DiscordCommands
    # Add music request from pre-generated playlists.
    # Max 5 songs for one request.
    module Playlist
      extend Discordrb::Commands::CommandContainer
      command(:playlist, min_args: 1, man_args: 2, bucket: :limit) do |event, file, n = 3|
        if !File.exist?("playlists/#{file.downcase}.txt")
          event << "#{file} playlist is not exist!"
          event << "Type `#{BOT.prefix}list` for playlists list!"
        else
          n = '5' if n.to_i > 5
          event.respond "#{n} tracks added by **#{event.user.name}** from __#{file.capitalize} playlist__"
          sleep 0.5
          File.readlines("playlists/#{file.downcase}.txt").sample(n.to_i).each do |i|
            m = event.respond "!add #{i}"
            sleep 1.1
            m.delete
          end
        end
        nil
      end
    end
  end
end
